%% @author hebin
%% @doc @todo Add description to emq_kafka_app.


-module(emq_kafka_app).

-behaviour(application).

-include("emq_kafka.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/2, stop/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_kafka_sup:start_link(),
	emq_kafka_hook:load(application:get_all_env()),
    emq_kafka_config:register(),
    {ok, Sup}.

stop(_State) ->
	emq_kafka_hook:unload(),
    emq_kafka_config:unregister().