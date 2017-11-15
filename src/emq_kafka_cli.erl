%% @author hebin
%% @doc @todo Add description to emq_kafka_cli.


-module(emq_kafka_cli).

-include("emq_kafka.hrl").

-include_lib("emqttd/include/emqttd.hrl").

-define(ENV(Key, Opts), proplists:get_value(Key, Opts)).

-export([connect/1, produce_sync/1]).

%%--------------------------------------------------------------------
%% kafka Connect/public
%%--------------------------------------------------------------------

connect(Opts) ->
	application:load(ekaf),
	application:set_env(ekaf, ekaf_bootstrap_broker, {?ENV(host, Opts), ?ENV(port, Opts)}),
	application:ensure_all_started(ekaf).

%% kafka public.
produce_sync(#mqtt_message{id = MsgId, pktid = PktId, from = From,
                     qos = Qos, retain = Retain, dup = Dup, topic =Topic, payload = Payload}) -> 
	ekaf:produce_sync(unicode:characters_to_binary(Topic), Payload).
