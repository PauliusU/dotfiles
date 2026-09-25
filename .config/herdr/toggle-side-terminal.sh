#!/usr/bin/env bash
# A herdr keybinding script. Toggles herdr's 65/35 side-terminal split
# Identifies its two panes by label. Probes herdr's own feature support first

set -u

MAIN_LABEL="main"
TERM_LABEL="scratch-term"
RATIO="0.65"

command -v herdr >/dev/null 2>&1 || exit 0
command -v jq    >/dev/null 2>&1 || exit 0

note() {
  herdr notification show "side-terminal" --body "$1" >/dev/null 2>&1 || true
}

# --- capability probes (read-only) --------------------------------------------
pane_help=$(herdr pane 2>&1)
have_rename=0; grep -q 'pane rename' <<<"$pane_help" && have_rename=1
have_zoom=0;   grep -q 'pane zoom' <<<"$pane_help" && have_zoom=1
have_toggle=0; grep -q -- '--toggle' <<<"$pane_help" && have_toggle=1
have_ratio=0
herdr pane split --help 2>&1 | grep -q -- '--ratio' && have_ratio=1

panes_json=$(herdr pane list 2>/dev/null) || exit 0

focused_pane_id=$(jq -r '
  .result.panes[]?
  | select(.focused == true)
  | .pane_id
' <<<"$panes_json" | head -1)
[ -z "$focused_pane_id" ] && exit 0

focused_tab_id=$(jq -r --arg p "$focused_pane_id" '
  .result.panes[]?
  | select(.pane_id == $p)
  | .tab_id
' <<<"$panes_json")

main_pane=$(jq -r --arg t "$focused_tab_id" --arg l "$MAIN_LABEL" '
  .result.panes[]?
  | select(.tab_id == $t and .label == $l)
  | .pane_id
' <<<"$panes_json" | head -1)

term_pane=$(jq -r --arg t "$focused_tab_id" --arg l "$TERM_LABEL" '
  .result.panes[]?
  | select(.tab_id == $t and .label == $l)
  | .pane_id
' <<<"$panes_json" | head -1)

panes_in_tab=$(jq -r --arg t "$focused_tab_id" '
  [.result.panes[]? | select(.tab_id == $t)]
  | length
' <<<"$panes_json")

# --- both panes known: hide/show ----------------------------------------------
if [ -n "$main_pane" ] && [ -n "$term_pane" ]; then
  if [ "$have_zoom" -eq 1 ] && [ "$have_toggle" -eq 1 ]; then
    zoom_result=$(herdr pane zoom --pane "$main_pane" --toggle 2>/dev/null)
    # NOT `// empty` - jq's // also treats JSON false as falsy
    now_zoomed=$(jq -r '.result.zoom.zoomed' <<<"$zoom_result")
    if [ "$now_zoomed" = "false" ]; then
      herdr pane focus --pane "$main_pane" --direction right >/dev/null 2>&1
    fi
  elif [ "$have_zoom" -eq 1 ]; then
    # older herdr without --toggle: derive the direction ourselves
    is_zoomed=$(jq -r --arg p "$main_pane" '
      .result.panes[]?
      | select(.pane_id == $p)
      | (.zoomed // false)
    ' <<<"$panes_json")
    if [ "$is_zoomed" = "true" ]; then
      herdr pane zoom --pane "$main_pane" --off >/dev/null 2>&1
      herdr pane focus --pane "$main_pane" --direction right >/dev/null 2>&1
    else
      herdr pane zoom --pane "$main_pane" --on >/dev/null 2>&1
    fi
  else
    # no zoom support: fall back to moving focus between the two panes
    if [ "$focused_pane_id" = "$term_pane" ]; then
      herdr pane focus --pane "$term_pane" --direction left >/dev/null 2>&1
    else
      herdr pane focus --pane "$main_pane" --direction right >/dev/null 2>&1
    fi
  fi
  exit 0
fi

# Without `pane rename` the lookups above never match a label - focus a
# sibling pane instead of splitting again
if [ "$have_rename" -eq 0 ] && [ "${panes_in_tab:-1}" -gt 1 ]; then
  herdr pane focus --pane "$focused_pane_id" --direction right >/dev/null 2>&1
  note "this herdr has no 'pane rename': switching panes instead"
  exit 0
fi

# --- first use in this tab, or the terminal pane was closed by hand -----------
main_pane="$focused_pane_id"
if [ "$have_rename" -eq 1 ]; then
  herdr pane rename "$main_pane" "$MAIN_LABEL" >/dev/null 2>&1
fi

cwd=$(jq -r --arg p "$main_pane" '
  .result.panes[]?
  | select(.pane_id == $p)
  | (.foreground_cwd // .cwd // empty)
' <<<"$panes_json")
if [ -z "$cwd" ] || [ "$cwd" = "null" ]; then cwd="$HOME"; fi

split_args=(--pane "$main_pane" --direction right --cwd "$cwd" --focus)
[ "$have_ratio" -eq 1 ] && split_args+=(--ratio "$RATIO")
new_pane=$(herdr pane split "${split_args[@]}" 2>/dev/null \
  | jq -r '.result.pane.pane_id // empty')

if [ -z "$new_pane" ]; then
  note "could not create the side terminal (herdr pane split failed)"
  exit 1
fi

if [ "$have_rename" -eq 1 ]; then
  herdr pane rename "$new_pane" "$TERM_LABEL" >/dev/null 2>&1
fi
exit 0
