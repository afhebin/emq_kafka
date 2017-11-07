%% @author hebin
%% @doc @todo Add description to emq_kafka_sup.

-module(emq_kafka_sup).

-behaviour(supervisor).

-include("emq_kafka.hrl").

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, Server} = application:get_env(?APP, server),
    PoolSpec = ecpool:pool_spec(?APP, ?APP, emq_kafka_cli, Server),
    {ok, {{one_for_one, 10, 100}, [PoolSpec]}}.

