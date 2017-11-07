%% @author hebin
%% @doc just for command line on shell. but this not implement.


-module(emq_kafka_cli).
-include_lib("emqttd/include/emqttd_cli.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([cmd/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================
cmd(["arg1", "arg2"]) ->
    ?PRINT_MSG("ok");

cmd(_) ->
    ?USAGE([{"cmd arg1 arg2",  "cmd demo"}]).