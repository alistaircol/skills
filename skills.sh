#!/usr/bin/env bash
export SKILLS_FONT_NAME="Cousine"

if [[ -z "${SKILLS_DIRECTION}" ]]; then
  export SKILLS_DIRECTION="LR"
fi

# orange
export SKILLS_EDGE_PRIMARY="[style = \"solid\" color = \"#f39c12\" arrowhead = \"none\"]"
# nephritis
export SKILLS_EDGE_SECONDARY="[style = \"solid\", color = \"#27ae60\" arrowhead = \"none\"]"
# belize hole
export SKILLS_EDGE_TERTIARY="[style = \"solid\", color = \"#2980b9\" arrowhead = \"none\"]"
# asbestos
export SKILLS_EDGE_QUATERNARY="[style = \"solid\", color = \"#7f8c8d\" arrowhead = \"none\"]"

# https://flatuicolors.com/palette/defo
# skills: sunflower/orange

# emerald/nephritis
export SKILLS_NODE_STYLE_PRIMARY="shape = \"box3d\" style = \"filled\" fillcolor = \"#2ecc71\" color = \"#27ae60\" penwidth=1 fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""

# peter river/belize hole
export SKILLS_NODE_STYLE_SECONDARY="shape = \"box3d\" style = \"filled\" fillcolor = \"#3498db\" color = \"#2980b9\" fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""

# concrete/asbestos
export SKILLS_NODE_STYLE_TERTIARY="shape = \"box3d\" style = \"filled\" fillcolor = \"#95a5a6\" color = \"#7f8c8d\" fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""

# clouds/silver text:
export SKILLS_NODE_STYLE_QUATERNARY="shape = \"box3d\" style = \"filled\" fillcolor = \"#ecf0f1\" color = \"#bdc3c7\" fontcolor=\"#000000\" fontname = \"${SKILLS_FONT_NAME}\""

envsubst < skills.tmpl.dot > skills.dot
