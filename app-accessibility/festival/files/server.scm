; Maximum number of clients on the server
(set! server_max_clients 10)

; Server port
(set! server_port 1314)

; Log file location
(set! server_log_file "/var/log/festival/festival.log")

; Set the server password
(set! server_passwd nil)

; Server access list (hosts)
; (set! server_access_list '("[^.]+" "127.0.0.1" "localhost.*" "192.168.*"))
(set! server_access_list '("[^.]+" "127.0.0.1" "localhost" ))


; Server deny list (hosts)
(set! server_deny_list nil)

