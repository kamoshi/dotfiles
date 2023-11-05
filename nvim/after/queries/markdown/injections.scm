; extends


(section
  [
    (
      ((paragraph) @s (#match? @s "^:::bibtex"))
      .
      (paragraph)*
      .
      ((paragraph) @e (#match? @e ":::$"))
    )
    ((paragraph) @p
      (#match? @p "^:::bibtex")
      (#match? @p ":::$")
    )
  ]

  (#set! injection.language "bibtex")
  (#set! injection.include-children)
  (#set! injection.combined)
) @injection.content
