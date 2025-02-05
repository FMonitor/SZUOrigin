coin_deposit:
    type: command
    debug: false
    name: coins
    aliases:
        - coin
    description: Deposit any coins to your bank
    usage: /coins deposit
    script:
    - inventory open destination:coins_inventory


coins_inventory:
    type: inventory
    debug: false
    inventory: chest
    title: <element[<&chr[f808]><&chr[f809]><&chr[f806]><&chr[E366]>].font[default].color[white]> <element[<&chr[f808]><&chr[f80b]><&chr[f80b]><&chr[f80a]><&chr[e367]>].font[default].color[white]> <placeholder[vault_eco_balance_commas].font[bank_font].color[white]>
    size: 45
    slots:
        - [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item]
        - [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item]
        - [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item]
        - [coin_filler_item] [coin_filler_item] [] [] [] [] [] [coin_filler_item] [coin_filler_item]
        - [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item] [coin_filler_item]
coins_item:
    type: item
    debug: false
    material: paper
    display name: "<gold>Coin"
    mechanisms:
        custom_model_data: 100149
coin_filler_item:
    type: item
    debug: false
    material: feather
    display name: "<gold>"
    mechanisms:
        custom_model_data: 10041

gui_handler:
    type: world
    debug: false
    events:
        on player clicks coin_filler_item in coins_inventory:
        - determine cancelled
        on player clicks !coins_item in coins_inventory:
        - determine cancelled
        after player drags coins_item in coins_inventory:
        - define quantity <context.inventory[coins_inventory].quantity_item[coins_item]>
        - if <[quantity]> >= 1:
            - inject script_gui_handler
            - inventory open destination:<inventory[coins_inventory]>
        after player closes coins_inventory:
        - define quantity <context.inventory[coins_inventory].quantity_item[coins_item]>
        - if <[quantity]> >= 1:
            - inject script_gui_handler
        after player clicks coins_item in coins_inventory:
        - define quantity <context.inventory[coins_inventory].quantity_item[coins_item]>
        - if <[quantity]> >= 1:
            - inject script_gui_handler
            - inventory open destination:<inventory[coins_inventory]>
        on player clicks coins_item in coins_inventory:
        - define quantity <context.inventory[coins_inventory].quantity_item[coins_item]>
        - if <[quantity]> >= 1:
            - inject script_gui_handler
            - inventory open destination:<inventory[coins_inventory]>
script_gui_handler:
    type: task
    debug: false
    script:
        - take item:coins_item quantity:<[quantity]> from:<context.inventory[coins_inventory]>
        - money give quantity:<[quantity]> players:<player>
        - narrate "<green>You just deposited <[quantity]><green> to your bank account!" targets:<player>




hero_eco_container:
    type: economy
    debug: false
    priority: lowest
    name single: <script[hero_eco].data_key[variables.currency_name]>
    name plural: <script[hero_eco].data_key[variables.currency_plural]>
    digits: 0
    format: <script[hero_eco].data_key[variables.currency_symbol]><[amount]>
    balance: <player.flag[money].if_null[0]>
    has: <player.flag[money].is[or_more].than[<[amount]>]>
    withdraw:
        - flag <player> money:-:<[amount]>
    deposit:
        - flag <player> money:+:<[amount]>

hero_eco:
    type: data
    pl_cmds:
        - pay
        - balance
        - bal
    cmds:
        - pay
        - deposit
        - withdraw
        - balance
        - bal
    variables:
        # Symbol when displaying money in text.
        currency_symbol: 
        # Currency name when displaying money.
        currency_name: Coin
        # Plural of above.
        currency_plural: Coins

eco_cmd:
    type: command
    debug: false
    name: eco
    aliases:
        - economy
    description: Economy command used for payment and balance checking.
    usage: /eco <white><&lt><gold><script[hero_eco].data_key[pl_cmds].separated_by[ <white>|<gold> ]><white><&gt>
    tab complete:
        - determine <proc[TabComplete].context[<list[data|EcoTabComplete].include_single[<context.raw_args>]>]>
    script:
        - choose <context.args.get[1].if_null[null]>:
            - case pay:
                - if <context.args.size> <= 2:
                    - narrate "<red>Not enough arguments provided for <&3>/<context.alias> <context.args.get[1]><red>.<&nl>Syntax: <&3><context.alias> <context.args.get[1]> <white><&lt><gold>player<white><&gt> <&lt><gold>amount<white><&gt>"
                    - stop
                - run eco_cmd_pay def.name:<context.args.get[2]> def.amt:<context.args.get[3]>
            - case deposit withdraw set:
                - if !<player.has_permission[economy.admin]>:
                    - narrate "<red>You do not have permission to use <&3>/<context.alias> <context.args.get[1]><red>."
                    - stop
                - if <context.args.size> <= 2:
                    - narrate "<red>Not enough arguments provided for <&3>/<context.alias> <context.args.get[1]><red>.<&nl>Syntax: <&3><context.alias> <context.args.get[1]> <white><&lt><gold>player<white><&gt> <&lt><gold>amount<white><&gt>"
                    - stop
                - run eco_cmd_<context.args.get[1]> def.name:<context.args.get[2]> def.amt:<context.args.get[3]>
            - case bal balance:
                - if <context.args.get[2].if_null[null]> == top:
                    - run eco_cmd_balance def.alt:true
                - else:
                    - run eco_cmd_balance def.alt:false
            - default:
                - if !<player.has_permission[economy.admin]>:
                    - narrate "<red>No arguments provided for <&3>/<context.alias><red>.<&nl>Syntax: <&3>/<context.alias> <white><&lt><gold><script[hero_eco].data_key[pl_cmds].separated_by[ <white>|<gold> ]><white><&gt>"
                - else:
                    - narrate "<red>No arguments provided for <&3>/<context.alias><red>.<&nl>Syntax: <&3>/<context.alias> <white><&lt><gold><script[hero_eco].data_key[cmds].separated_by[ <white>|<gold> ]><white><&gt>"
eco_cmd_pay:
    type: task
    debug: false
    definitions: name|amt
    script:

        - if <player.money> <= 0:
            - narrate "<red>You do not have any money to pay with."
            - stop

        - if !<[amt].is_integer>:
            - narrate "<red>The amount of <gold><[amt]><red> you've provided is not a valid number."
            - stop

        - if <player.money> < <[amt]>:
            - narrate "<red>You do not have enough money to pay <gold><[amt]><red>."
            - stop

        - if !<server.match_player[<[name]>].exists>:
            - narrate "<red>The player <gold><[name]><red> is not currently online."
            - stop

        - define target <server.match_player[<[name]>]>
        - if <[target]> == <player>:
            - narrate "<red>You can not pay yourself."
            - stop

        - money take players:<player> quantity:<[amt]>
        - money give players:<[target]> quantity:<[amt]>
        - narrate "<white>You paid <gold><[target].display_name> <&a><[amt].proc[eco_display_amt]>."
        - narrate "<white>You were paid <&a><[amt].proc[eco_display_amt]>. by <gold><player.display_name><white>." targets:<[target]>
eco_cmd_withdraw:
    type: task
    debug: false
    definitions: name|amt
    script:

        - if !<[amt].is_integer>:
            - narrate "<red>The amount of <gold><[amt]><red> you've provided is not a valid number."
            - stop

        - if <[amt]> <= 0:
            - narrate "<red>You must supply an amount greater than <gold>0<red>."
            - stop

        - if !<server.match_offline_player[<[name]>].exists>:
            - narrate "<red>The player <gold><[name]><red> does not exist."
            - stop

        - define target <server.match_offline_player[<[name]>]>
        - if <[target].money> <= 0:
            - narrate "<red>The player <gold><[name]><red> does not have any money to take."
            - stop

        - if <[target].money.sub[<[amt]>]> <= 0:
            - define amt <[target].money>
            - narrate "<&7><&o>The player <gold><&o><[name]><&7><&o> did not have enough money to withdraw, amount changed to <&a><&o><server.economy.format[<[amt]>].format_number><&7><&o>."

        - money take players:<[target]> quantity:<[amt]>
        - narrate "<white>You administratively withdrawn <white><[amt].proc[eco_display_amt]> from <gold><[target].display_name>'s<white> account."
        - if <[target].is_online>:
            - narrate "<white><[amt].proc[eco_display_amt]> <dark_red>Server <white>was withdrawn from your account by <gold><player.display_name><white>." targets:<[target]>
eco_cmd_set:
    type: task
    debug: false
    definitions: name|amt
    script:

        - if !<[amt].is_integer>:
            - narrate "<red>The amount of <gold><[amt]><red> you've provided is not a valid number."
            - stop

        - if <[amt]> < 0:
            - narrate "<red>You must supply a positive amount."
            - stop

        - if !<server.match_offline_player[<[name]>].exists>:
            - narrate "<red>The player <gold><[name]><red> does not exist."
            - stop

        - define target <server.match_offline_player[<[name]>]>
        - money set players:<[target]> quantity:<[amt]>
        - narrate "<dark_red>Server <white> set <gold><[target].display_name>'s<white> account balance to <&a><[amt].proc[eco_display_amt]>."
        - if <[target].is_online>:
            - narrate "<white>Your account balance was set to <white><[amt].proc[eco_display_amt]> by <gold><player.display_name><white>." targets:<[target]>
eco_cmd_deposit:
    type: task
    debug: false
    definitions: name|amt
    script:

        - if !<[amt].is_integer>:
            - narrate "<red>The amount of <gold><[amt]><red> you've provided is not a valid number."
            - stop

        - if !<server.match_offline_player[<[name]>].exists>:
            - narrate "<red>The player <gold><[name]><red> does not exist."
            - stop

        - define target <server.match_offline_player[<[name]>]>
        - money give players:<[target]> quantity:<[amt]>
        - if <[target].is_online>:
            - narrate "<white><[amt].proc[eco_display_amt]> <green>server deposited into your account by <gold><player.display_name><white>." targets:<[target]>
eco_alias_balance:
    type: command
    debug: false
    name: balance
    aliases:
        - bal
    description: <gold>Alias for <white>/eco balance
    usage: /balance (top)
    tab complete:
        - determine <list[top]>
    script:
        - if <context.args.get[1].if_null[null]> == top:
            - run eco_cmd_balance def.alt:true
        - else:
            - run eco_cmd_balance def.alt:false
eco_cmd_balance:
    type: task
    debug: false
    definitions: alt
    script:

        - if <[alt]>:
            - define player <server.players.highest[money].count[10]>
            - define "top_txt:->:<green><&l>TOP 10 WEALTHIEST"
            - define top_txt:->:<&7><&l>--------------------------------------------<&nl>
            - foreach <[player]> as:pl:
                - choose <[loop_index]>:
                    - case 1:
                        - define num_color <&6>
                    - case 2:
                        - define num_color <white>
                    - case 3:
                        - define num_color <gold>
                    - default:
                        - define num_color <&7>
                - define "pl_list:->:<[num_color]><[loop_index]>. <white><script[hero_eco].data_key[variables.currency_symbol]><green><[pl].money.format_number> <white><[pl].name>"
            - define top_txt:->:<[pl_list].separated_by[<&nl>]>
            - define top_txt:->:<&nl><&7><&l>--------------------------------------------
            - narrate <[top_txt].separated_by[<&nl>]>
        - else:
            - if !<player.exists>:
                - narrate "<red>This is a player only command. Use <&3>/balance top<red>."
                - stop
            - narrate "<white>You currently have <green><player.money.proc[eco_display_amt]>."
eco_display_amt:
    type: procedure
    debug: false
    definitions: amt
    script:
        - define curr_name <proc[eco_get_name]>
        - if <[amt]> > 1 || <[amt]> < -1:
            - define curr_name <proc[eco_get_plural]>
        - determine "<script[hero_eco].data_key[variables.currency_symbol]><[amt].format_number><white> <[curr_name]>"
eco_get_plural:
    type: procedure
    debug: false
    script:
        - determine <script[hero_eco].data_key[variables.currency_plural]>
eco_get_name:
    type: procedure
    debug: false
    script:
        - determine <script[hero_eco].data_key[variables.currency_name]>
EcoTabComplete:
    type: data
    data:
        pay: end
        balance:
            top: end
        ?economy.admin deposit:
            _*players:
                _*amt: end
        ?economy.admin withdraw:
            _*players:
                _*amt: end
        ?economy.admin set:
            _*players:
                _*amt: end

EcoTabComplete_players:
    type: procedure
    debug: false
    script:
        - determine <server.online_players.parse[name]>

EcoTabComplete_amt:
    type: procedure
    debug: false
    script:
        - determine <list[1|10|100|1000|10000|100000]>

TabComplete:
  type: procedure
  debug: false
  definitions: command|data|raw_args
  script:
    - define raw_args <[raw_args].if_null[<empty>]>
    - define newArg '<[raw_args].ends_with[ ].or[<[raw_args].equals[<empty>]>]>'
    - define script <script[<[data]>]>
    - define currentData <[script].data_key[<[command]>]>
    - define args <list>
    - if <[raw_args]> != <empty>:
      - define 'args:|:<[raw_args].split[ ]>'
    - define argsSize <[args].size>
    - if <[newArg]>:
      - define argsSize:+:1
    - repeat <[argsSize].sub[1].round_down> as:index:
      - define value <[args].get[<[index]>]>
      - if <[value]> == <empty>:
        - repeat next
      - define keys <[currentData].keys>
      - define permLockedKeys <[keys].filter[starts_with[?]]>
      - define keys:<-:<[permLockedKeys]>
      - if <[keys].contains[<[value]>]>:
        - define currentData <[currentData].get[<[value]>]>
      - else if <[permLockedKeys].size> > 0:
        - define perm '<[permLockedKeys].filter[ends_with[ <[value]>]]>'
        - if <[perm].is_empty> || '!<player.has_permission[<[perm].first.after[?].before[ ].unescaped>]>':
          - determine <list>
        - define currentData <[currentData].get[<[perm].first>]>
      - else:
        - define default <[keys].filter[starts_with[_]]>
        - if <[default].is_empty>:
          - determine <list>
        - define currentData <[currentData].get[<[default].first>]>
      - if <[currentData]> == end:
        - determine <list>
    - foreach <[currentData].keys>:
      - if <[value].starts_with[_]>:
        - define value <[value].after[_]>
        - if <[value].starts_with[*]>:
          - define ret:|:<proc[<[data]>_<[value].after[*]>].context[<[args]>]>
      - else if <[value].starts_with[?]>:
        - define perm '<[value].before[ ].after[?].unescaped>'
        - if <player.has_permission[<[perm]>]>:
          - define 'ret:|:<[value].after[ ]>'
      - else:
        - define ret:->:<[value]>
    - if !<[ret].exists>:
      - determine <list>
    - if <[newArg]>:
      - determine <[ret]>
    - determine <[ret].filter[starts_with[<[args].last>]]>