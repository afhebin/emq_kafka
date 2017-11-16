%% @author hebin
%% @doc @todo Add description to emq_kafka_hook.


-module(emq_kafka_hook).

%% ====================================================================
%% API functions
%% ====================================================================
-include_lib("emqttd/include/emqttd.hrl").

-export([load/1, unload/0]).

%% Hooks functions

-export([on_message_publish/2]).

%% Called when the plugin application start
load(Env) ->
    emqttd:hook('message.publish', fun ?MODULE:on_message_publish/2, [Env]).

%% transform message and return
on_message_publish(Message = #mqtt_message{topic = <<"$SYS/", _/binary>>}, _Env) ->
    %% emq_kafka_cli:produce_sync(Message),
	{ok, Message};

on_message_publish(Message, _Env) ->
	emq_kafka_cli:produce_sync(Message),
    {ok, Message}.

%% Called when the plugin application stop
unload() ->
    emqttd:unhook('message.publish', fun ?MODULE:on_message_publish/2).
