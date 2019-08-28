project_name: "km_sandbox"

# localization_settings: {
#   # localization_level: [strict | permissive]
#   localization_level: permissive
#   default_locale: en
# }

constant: owner {
  value: "{% if _explore._name == 'users__constants' %} 'Matched' {% else %} Default Placeholder{%endif%}"
  }

constant: test_constant {
  value: "02349_sfo"
}

constant: constant__now {
  value: "{{'now' | date: '%Y'}}"
}

constant: format_as_integer {value: "{{ value | round }}"}

constant: format_as_round_to_10s {value: "{{ value | round:1 }}"}

constant: camelize {
  value:
  "
  capitalize
  | replace: ' a',' A'
  | replace: ' b',' B'
  | replace: ' c',' C'
  | replace: ' d',' D'
  | replace: ' e',' E'
  | replace: ' f',' F'
  | replace: ' g',' G'
  | replace: ' h',' H'
  | replace: ' i',' I'
  | replace: ' j',' J'
  | replace: ' k',' K'
  | replace: ' l',' L'
  | replace: ' m',' M'
  | replace: ' n',' N'
  | replace: ' o',' O'
  | replace: ' p',' P'
  | replace: ' q',' Q'
  | replace: ' r',' R'
  | replace: ' s',' S'
  | replace: ' t',' T'
  | replace: ' u',' U'
  | replace: ' v',' V'
  | replace: ' x',' X'
  | replace: ' y',' Y'
  | replace: ' z',' Z'
  "
}
