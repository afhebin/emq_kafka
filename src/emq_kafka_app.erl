%% @author hebin
%% @doc app define.

-module(emq_kafka_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_kafka_sup:start_link(),
	emq_kafka_config:init("test"),
	%% emq_kafka:load(application:get_all_env()),
	{ok, Sup}.

stop(_State) ->
	emq_kafka:unload(),
    ok.
