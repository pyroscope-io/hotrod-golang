# Hot R.O.D. - Rides on Demand

The project is a fork of
https://github.com/jaegertracing/jaeger/tree/master/examples/hotrod.
All the credits go to the authors.

We use the application in [examples]((https://github.com/pyroscope-io/pyroscope/tree/main/examples/pull)) of how
Pyroscope server pulls profiling data from remote targets.

## Enable pprof endpoints

The only change we made is enabling `pprof` endpoints – see [main.go](main.go):
```go
func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/debug/pprof/", pprof.Index)
	mux.HandleFunc("/debug/pprof/cmdline", pprof.Cmdline)
	mux.HandleFunc("/debug/pprof/profile", pprof.Profile)
	mux.HandleFunc("/debug/pprof/symbol", pprof.Symbol)
	mux.HandleFunc("/debug/pprof/trace", pprof.Trace)
	go func() {
		log.Println(http.ListenAndServe(":6060", mux))
	}()

	cmd.Execute()
}
```

Note that `pprof` package can also register endpoints globally:

```go
package main

import (
	"fmt"
	"net/http"
	_ "net/http/pprof"
)

func main() {
	// Server for pprof.
	go func() {
		fmt.Println(http.ListenAndServe(":6060", nil))
	}()

	// Your code.
}
```

Please, refer to [`pprof` package documentation](https://pkg.go.dev/net/http/pprof) and
[diagnostics guide](https://golang.org/doc/diagnostics) to learn more.
