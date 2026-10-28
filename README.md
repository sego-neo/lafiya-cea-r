# Lafiya Nigeria CEA — R rebuild (work in progress)

Rebuild of Rethink Priorities' cost-effectiveness analysis of Lafiya Nigeria's family-planning programme, in R.
`01_model.R` implements the model (base case: $10.69 per DALY averted at 94% additionality) and a sensitivity grid across additionality (50–100%) with child DALYs included/excluded.
See `sensitivity.png` for the main chart. Inputs follow RP's published figures; critique of additionality and child-DALY assumptions in the companion Google Sheet.
Possible extensions: Shiny dashboard with interactive sliders.
