#!/usr/bin/env bash
export SKILLS_FONT_NAME="Cousine"

export SKILLS_EDGE_PRIMARY="[style = \"solid\" color = \"#1b8654\" arrowhead = \"none\"]"
export SKILLS_EDGE_SECONDARY="[style = \"solid\", color = \"#0c6efd\" arrowhead = \"none\"]"
export SKILLS_EDGE_TERTIARY="[style = \"solid\", color = \"#6d757d\" arrowhead = \"none\"]"
export SKILLS_EDGE_QUATERNARY="[style = \"solid\", color = \"#f8f9fa\" arrowhead = \"none\"]"

export SKILLS_NODE_STYLE_PRIMARY="shape = \"cds\" style = \"filled\" fillcolor = \"#1b8654\" color = \"#1b8654\" penwidth=1 fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""
export SKILLS_NODE_STYLE_SECONDARY="shape = \"cds\" style = \"filled\" fillcolor = \"#0c6efd\" color = \"#0c6efd\" fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""
export SKILLS_NODE_STYLE_TERTIARY="shape = \"cds\" style = \"filled\" fillcolor = \"#6d757d\" color = \"#6d757d\" fontcolor=\"#ffffff\" fontname = \"${SKILLS_FONT_NAME}\""
export SKILLS_NODE_STYLE_QUATERNARY="shape = \"cds\" style = \"filled\" fillcolor = \"#f8f9fa\" color = \"#f8f9fa\" fontname = \"${SKILLS_FONT_NAME}\""

envsubst < skills.tmpl.dot > skills.dot
