; extends


(section
  ((paragraph) @p
    (#match? @p "^:::bib")
  )

  (#set! injection.language "bibtex")
  (#set! injection.include-children)
  (#set! injection.combined)
) @injection.content

(section
  ((paragraph) @s (#match? @s "^:::bib"))
  .
  (paragraph)*
  .
  ((paragraph) @e (#match? @e ":::"))

  (#set! injection.language "bibtex")
  (#set! injection.include-children)
  (#set! injection.combined)
) @injection.content
