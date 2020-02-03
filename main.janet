(defn slurp-number-
  [f]
  (->> f
       (slurp)
       (string/trim)
       (scan-number)))

(defn toggle-brightness
  [trigger-name]
  (let [base-path          (string "/sys/class/leds/" trigger-name)
        brightness         (string base-path "/brightness")

        current-brightness (slurp-number- brightness)
        max-brightness     (slurp-number- (string base-path "/max_brightness"))
        new-value          (string
                            (if (zero? current-brightness)
                              max-brightness
                              0))]
    (file/write stderr
                (string "writing "
                        new-value
                        " to "
                        brightness
                        " (was " current-brightness ")"
                        "\n"))
    (with [out (file/open brightness :w)]
          (file/write out new-value))))

(defn main
  [_0 & targets]
  (when (empty? targets)
    (file/write stderr
                "no targets; exiting\n")
    (os/exit 1))
  # (file/write stdout
  #             (string
  #              (string/join args " ") "\n"))
  (map toggle-brightness targets)
  # (toggle-brightness "input4::capslock")
  )
