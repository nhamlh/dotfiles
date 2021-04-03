;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       company                          ; the ultimate code completion backend
       ivy                              ; a search engine for love and life

       :ui
       doom                   ; what makes DOOM look the way it does
       doom-dashboard         ; a nifty splash screen for Emacs
       doom-quit              ; DOOM quit-message prompts when you quit Emacs
       hl-todo                ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra
       indent-guides              ; highlighted indent columns
       modeline                   ; snazzy, Atom-inspired modeline, plus API
       nav-flash                  ; blink the current line after jumping
       ophints                    ; highlight the region an operation acts on
       (popup                     ; tame sudden yet inevitable temporary windows
        +all                      ; catch all popups that start with an asterix
        +defaults)                ; default popup rules

       ligatures              ; replace bits of code with pretty symbols
       treemacs               ; a project drawer, like neotree but cooler
       unicode                ; extended unicode support for various languages
       vc-gutter              ; vcs diff in the fringe
       vi-tilde-fringe        ; fringe tildes to mark beyond EOB
       window-select          ; visually switch windows
       workspaces             ; tab emulation, persistence & separate workspaces
       deft

       :editor
       (evil +everywhere)        ; come to the dark side, we have cookies
       file-templates            ; auto-snippets for empty files
       fold                      ; (nigh) universal code folding
       (format +onsave)          ; automated prettiness
       lispy                     ; vim for lisp, for people who don't like vim
       multiple-cursors          ; editing in many places at once
       rotate-text               ; cycle region at point between text candidates
       snippets                  ; my elves. They type so I don't have to
       word-wrap                 ; soft wrapping with language-aware indent

       :emacs
       (dired                           ; making dired pretty [functional]
        +icons)
       electric                   ; smarter, keyword-based electric-indent
       ibuffer                    ; interactive buffer management
       vc                         ; version-control and Emacs, sitting in a tree
       undo

       :term
       vterm                            ; another terminals in Emacs

       :tools
       debugger              ; FIXME stepping through code, to help you add bugs
       ;;direnv
       docker
       ;;editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)          ; run code, run (also, repls)
       (lookup                  ; helps you navigate your code and documentation
        +docsets)               ; ...or in Dash docsets locally
       lsp
       (magit +forge)         ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       pdf        ; pdf enhancements
       prodigy    ; FIXME managing external services & code builders
       ;;rgb               ; creating color strings
       terraform  ; infrastructure as code
       ;;upload            ; map local to remote projects via ssh/ftp

       :lang
       ;;cc                ; C/C++/Obj-C madness
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       data                             ; config/data formats
       emacs-lisp                       ; drown in parentheses
       (go +lsp)                        ; the hipster dialect
       (haskell
        +dante
        +lsp)     ; a language that's lazier than I am
       ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
       lua                           ; one-based indices? one-based indices
       markdown                      ; writing docs for people to ignore
       (org                          ; organize your plain life in plain text
        +dragndrop                   ; drag & drop files/images into org buffers
        +pomodoro                    ; be fruitful with the tomato technique
        ;+roam
        +present)        ; using org-mode for presentations
       plantuml          ; diagrams for confusing people more
       (python +lsp)     ; beautiful is better than ugly
       ;;rest              ; Emacs as a REST client
       (ruby +lsp)       ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (racket +lsp)
       sh                            ; she sells {ba,z,fi}sh shells on the C xor
       ;;web               ; the tubes
       yaml

       (rust +lsp)

       :checkers
       syntax                        ; tasing you for every semicolon you forget

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;;write             ; emacs for writers (fiction, notes, papers, etc.)

       :config
       ;;literate
       (default +bindings +smartparens))
