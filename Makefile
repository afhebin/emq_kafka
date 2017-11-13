PROJECT = emq_kafka
PROJECT_DESCRIPTION = Authentication/ACL with Redis
PROJECT_VERSION = 1.0

DEPS = ekaf ecpool clique

dep_ekaf = git https://github.com/helpshift/ekaf
dep_ecpool = git https://github.com/emqtt/ecpool master
dep_clique = git https://github.com/emqtt/clique

BUILD_DEPS = emqttd cuttlefish
dep_emqttd = git https://github.com/emqtt/emqttd master
dep_cuttlefish = git https://github.com/emqtt/cuttlefish

NO_AUTOPATCH = cuttlefish

COVER = true

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'

include erlang.mk

app:: rebar.config

app.config::
	deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emq_kafka.conf -i priv/emq_kafka.schema -d data
