;; File: cfg-mode.el
;; Author: Jacob Komissar
;; Date: 2017-02-14, 2017-06-09
;; Copyright © 2017 Jacob Komissar

;; A major mode for editing context-free grammars.

;; Inspired by the BNF mode from here:
;; https://www.reddit.com/r/emacs/comments/af2sg/bnfmode_for_emacs/

(define-generic-mode 'cfg-mode
  (list (cons "/;" ";/")) ;; comment chars
  ;; I want ;; to be a comment character, but if I add it, it has to be termianted.
  ;; ?\; works as a comment character, but I don't want to catch terminal semicolons...
  (list "ε" "λ") ;; keywords
  '(
	("^[[:space:]]*;[^`\n]*`?" . 'font-lock-comment-face) ; comments at start of line with ;, end with ` or newline

	("^[[:space:]]*<[^ >]*>" . 'font-lock-function-name-face) ; named nonterminal definitions
	("<[^ >]*>" . 'font-lock-variable-name-face) ; named nonterminals
	("^[[:space:]]*[[:upper:]]" . 'font-lock-function-name-face) ; Nonterminal defintions
	("[[:upper:]]" . 'font-lock-variable-name-face) ; Nonterminals

	("[][]" . 'font-lock-comment-face) ; brackets for meta-markings
	("->"    . 'font-lock-type-face) ; produces
	(" => "  . 'font-lock-doc-face) ; producing
	("|"    . 'font-lock-warning-face) ; "OR" symbol
	("." . 'font-lock-constant-face) ; terminals
	; [[:lower:][:punct:][:digit:]] would be terminals, but the rule used is better.
	)
  '("\\.cfg\\'") ;; filename suffixes
  '((lambda () (modify-syntax-entry ?\" ".")) ; quote is punctuation, not a string quote
	(lambda () (setq show-trailing-whitespace t))
	;; This doesn't do what I want. I want the tab key to always insert tabs.
;	(lambda () (setq-local indent-line-function (lambda () (interactive) (insert "\t"))))
	) ;; extra function hooks
  "Major mode for highlighting cotnext-free grammars.

Line comments may start with # or ;
Multiline comments are delimited by /; and ;/.
Variables may be capital letters, or delimited by < and >
 (these may never contain spaces).
Productions are denoted by ->
Alternate productions are may be denoted with |
Generation is denoted by =>
[ and ] are highlighted as comments for delimiting blocks.
Lowercase lambda and epsilon are keywords, respresenting the empty string.
All other symbols are terminals.")

;; These could be used for string syntax, but then I lose literal quote terminals.
;;   "([^\"]|\.)*?"
;; ("\"\\([^\"\\\\]\\|\\\\\\.\\)*?\"" . 'font-lock-string-face)
;; ("'\\([^'\\\\]\\|\\\\\\.\\)*?'" . 'font-lock-string-face)

(provide 'cfg-mode)
