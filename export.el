(require 'elfeed)
(require 'elfeed-org)

(setq rmh-elfeed-org-files (list "feeds.org"))
(elfeed-org)
(elfeed)
(elfeed-update)
(elfeed-export-opml "feeds.opml")
