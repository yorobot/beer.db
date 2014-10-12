
# -- input repo sources config

# -- world.db --

OPENMUNDI_ROOT           = "../../openmundi"
WORLD_DB_INCLUDE_PATH    = "#{OPENMUNDI_ROOT}/world.db"
AUSTRIA_DB_INCLUDE_PATH  = "#{OPENMUNDI_ROOT}/austria.db"


# -- beer.db --

OPENBEER_ROOT = ".."

WORLD_INCLUDE_PATH            = "#{OPENBEER_ROOT}/world"

DE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/de-deutschland"
AT_INCLUDE_PATH               = "#{OPENBEER_ROOT}/at-austria"
CH_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ch-confoederatio-helvetica"
CZ_INCLUDE_PATH               = "#{OPENBEER_ROOT}/cz-czech-republic"
IE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ie-ireland"
BE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/be-belgium"
NL_INCLUDE_PATH               = "#{OPENBEER_ROOT}/nl-netherlands"

CA_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ca-canada"
US_INCLUDE_PATH               = "#{OPENBEER_ROOT}/us-united-states"
MX_INCLUDE_PATH               = "#{OPENBEER_ROOT}/mx-mexico"

JP_INCLUDE_PATH               = "#{OPENBEER_ROOT}/jp-japan"



#########################################
# debug - print settings/repo paths

settings = <<EOS
*****************
settings:
  WORLD_DB_INCLUDE_PATH:   #{WORLD_DB_INCLUDE_PATH}
  AUSTRIA_DB_INCLUDE_PATH: #{AUSTRIA_DB_INCLUDE_PATH}

  WORLD_INCLUDE_PATH:        #{WORLD_INCLUDE_PATH}
  DE_INCLUDE_PATH:           #{DE_INCLUDE_PATH}
  AT_INCLUDE_PATH:           #{AT_INCLUDE_PATH}
  CH_INCLUDE_PATH:           #{CH_INCLUDE_PATH}
  CZ_INCLUDE_PATH:           #{CZ_INCLUDE_PATH}
  IE_INCLUDE_PATH:           #{IE_INCLUDE_PATH}
  BE_INCLUDE_PATH:           #{BE_INCLUDE_PATH}
  NL_INCLUDE_PATH:           #{NL_INCLUDE_PATH}
  CA_INCLUDE_PATH:           #{CA_INCLUDE_PATH}
  US_INCLUDE_PATH:           #{US_INCLUDE_PATH}
  MX_INCLUDE_PATH:           #{MX_INCLUDE_PATH}
  JP_INCLUDE_PATH:           #{JP_INCLUDE_PATH}
*****************
EOS

puts settings
