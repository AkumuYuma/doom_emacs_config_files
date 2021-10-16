;; ------------------------- Comandi personali (funzioni interattive) -------------------------

(defun codice_linguaggio (stringa)
  "Scrive
#+begin_src <stringa>
#+end_src
Specificando il linguaggio da linea di comando."
  (interactive "MLinguaggio: ")
  (insert "#+begin_src " stringa "\n#+end_src"))

(defun root_source (nome_file)
  "Scrive
#+begin_src cpp :main no :mkdirp yes :tangle macros/<nome_file>.cpp
#+end_src
Utile per prendere appunti su root e poi tanglare i source blocks.
"
  (interactive "MInserire nome file: ")
  (codice_linguaggio (concat "cpp :main no :mkdirp yes :tangle macros/" nome_file ".cpp")))



(defun org-babel-tangle-block ()
  "Chiama la funzione org-babel-tangle utilizzando un prefix argument. Dalla documentazione di
org-babel-tangle block, chiamandola con un prefix arg tangla solo un blocco"
  (interactive)
  (let ((current-prefix-arg '(4)))
    ;; In questo scope ho cambiato il valore della variabile current-prefix-arg.
    ;; Ho impostato usando una lista che contiene un numero
    ;; A quanto pare funziona solo con il 4 (vedi documentazione current-prefix-arg.)
    (call-interactively 'org-babel-tangle))
  )


(provide 'funzioni-generiche)
