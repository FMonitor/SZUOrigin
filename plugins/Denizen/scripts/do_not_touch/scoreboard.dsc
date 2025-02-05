icons:
    type: data
    ranks:
        admin: <element[a].font[mcbars:ranks].color[white]>
    logo:
        coin: <element[$].font[mcbars:icons].color[white]>
    spaces:
        1: <element[0].font[mcbars:spaces].color[white]>
        2: <element[1].font[mcbars:spaces].color[white]>
        4: <element[2].font[mcbars:spaces].color[white]>
        8: <element[3].font[mcbars:spaces].color[white]>
        16: <element[4].font[mcbars:spaces].color[white]>
        32: <element[5].font[mcbars:spaces].color[white]>
        64: <element[6].font[mcbars:spaces].color[white]>
        128: <element[7].font[mcbars:spaces].color[white]>
        256: <element[8].font[mcbars:spaces].color[white]>
        512: <element[9].font[mcbars:spaces].color[white]>
        dialogue_frame: <element[].font[minecraft:default].color[white]>
scoreboard_data:
    type: data
    refresh rate: 5
    presets:
        admin:
            enabled: true
            conditions:
            - <player.groups.contains[admin]>
            title:
                text:
                - Admin only haha
                animation interval: 1s
                has animation: true
            lines:
                1:
                    text:
                    - haha lol
                2:
                    text:
                    - 1
                    - 2
                    animation interval: 1s
                    has animation: false
                    conditions:
                    - <player.gamemode.equals[creative]>
                3:
                    text:
                    - only in gmc!
                    - lol
                    animation interval: 5t
                    has animation: true
                    conditions:
                    - <player.gamemode.equals[creative]>
                4:
                    text:
                    - only in gmc!
                    - lol
                    animation interval: 34t
                    has animation: true
                    conditions:
                    - <player.gamemode.equals[creative]>
                5:
                    text:
                    - only in gmc!
                    - lol
                    animation interval: 3s
                    has animation: true
                    conditions:
                    - <player.gamemode.equals[creative]>
                6:
                    text:
                    - only in gmc!
                    - lol
                    animation interval: 5t
                    has animation: true
                    conditions:
                    - <player.gamemode.equals[creative]>
                7:
                    text:
                    - only in gmc!
                    - lol
                    animation interval: 2t
                    has animation: true
                    conditions:
                    - <player.gamemode.equals[creative]>
        default:
            title:
                text:
                - <&[emphasis]><bold><white> 
                has animation: false
            lines:
                ranks:
                    text:
                    - <empty>
                    - <empty>
                    - <white> <gold>等级<black>: <gray><placeholder[luckperms_prefix]>
                vital:
                    text:
                    - <&sp.repeat[5].strikethrough.color_gradient[from=aqua;to=blue]><reset> <dark_purple><bold>生命体征 <&sp.repeat[5].strikethrough.color_gradient[from=blue;to=aqua]>
                    - <&sp.repeat[5].strikethrough.color_gradient[from=aqua;to=blue]><reset> <light_purple><bold>生命体征 <&sp.repeat[5].strikethrough.color_gradient[from=blue;to=aqua]>
                    - <&sp.repeat[5].strikethrough.color_gradient[from=aqua;to=blue]><reset> <gold><bold>生命体征 <&sp.repeat[5].strikethrough.color_gradient[from=blue;to=aqua]>
                    - <&sp.repeat[5].strikethrough.color_gradient[from=aqua;to=blue]><reset> <yellow><bold>生命体征 <&sp.repeat[5].strikethrough.color_gradient[from=blue;to=aqua]>
                    animation interval: 0.3s
                    has animation: true
                stats:
                    text:
                    - <red>❤ <green><player.flag[the_progress_bar.health]>
                    - <yellow>☕ <player.flag[the_progress_bar.hunger]>
                money:
                    text:
                    - <empty>
                    - <white> <player.money>
                    - <empty>
                    - ᴛᴘꜱ <server.flag[the_progress_bar.tps]>
                server:
                    text:
                    - <gray> 在线玩家数<&co> <yellow><server.online_players.size>
                    - <gray> 在线玩家数<&co> <gold><server.online_players.size>
                    animation interval: 0.5s
                    has animation: true
                line:
                    text:
                    - <empty>

#Use this of the scoreboard have a logo  
# and this is for without logo 

scoreboard_toggle_command:
    type: command
    name: sidebar
    description: Toggles the scoreboard
    usage: /sidebar
    permission: sidebar.command.sidebar
    debug: false
    script:
    - if !<player.exists>:
        - narrate "<&[error]>You must be a player to use this command!"
        - stop
    - if <player.has_flag[scoreboard.enabled]>:
        - flag <player> scoreboard.enabled:<player.flag[scoreboard.enabled].not>
        - narrate "<&[success]>scoreboard <player.flag[scoreboard.enabled].if_true[enabled].if_false[disabled]>!"
        - sidebar remove
    - else:
        - flag <player> scoreboard.enabled:true
        - narrate "<&[success]>scoreboard enabled!"

scoreboard_change_preset_command:
    type: command
    name: sidebarpreset
    description: Does something
    usage: /sidebarpreset [preset] (player)
    permission: sidebar.command.sidebarpreset
    debug: false
    tab completions:
        1: <player.proc[scoreboard_get_available_presets_proc].if_null[]>
        2: <server.online_players.parse[name]>
    script:
    - define caster <player.if_null[null]>
    - if <context.args.size> < 1:
        - narrate "<&[error]>Invalid! <script.data_key[usage]>"
        - stop
    - if <context.args.size> >= 2:
        - define player <server.match_player[<context.args.get[2]>].if_null[null]>
        - if <[player]> == null:
            - narrate "<&[error]>Invalid player name <[player]>"
            - stop
        - adjust <queue> linked_player:<[player]>
    - else if !<player.exists>:
        - narrate "<&[error]>Specify a player!"
        - stop
    - if <player.proc[scoreboard_get_available_presets_proc]> !contains <context.args.get[1]>:
        - if <[caster]> != null:
            - if <[caster].proc[scoreboard_get_available_presets_proc]> !contains <context.args.get[1]>:
                - narrate "<&[error]>This player cannot use this preset, and neither can you!" targets:<[caster]>
                - stop
    - if <[caster]> != null:
        - if <[caster]> != <player> && !<[caster].has_permission[scoreboard.command.scoreboard.other]>:
            - narrate "<&[error]>You do not have the permission to do this on others!" targets:<[caster]>
            - stop
    - flag <player> scoreboard.preset:<context.args.get[1]>
    - run scoreboard_process_scoreboard_task
scoreboard_get_available_presets_proc:
    type: procedure
    debug: false
    definitions: player
    script:
    - define __player <[player]>
    - determine <script[scoreboard_data].data_key[presets].filter_tag[<[filter_value.conditions].if_null[<list>].parse[parsed.not].filter[].is_empty>].filter_tag[<[filter_value.enabled].if_null[true]>].keys>
scoreboard_process_scoreboard_task:
    type: task
    debug: false
    script:
    - if !<player.has_flag[scoreboard.enabled]> || !<player.flag[scoreboard.enabled]>:
        - stop
    - define scoreboard_preset <player.flag[scoreboard.preset].if_null[<player.proc[scoreboard_get_available_presets_proc].first.if_null[__null]>]>
    - if <[scoreboard_preset]> == __null:
        - stop
    - define scoreboard_data <proc[scoreboard_process_lines_proc].context[<[scoreboard_preset]>]>
    - sidebar title:<[scoreboard_data.title]> values:<[scoreboard_data.lines]> players:<player>
scoreboard_main_runner_world:
    type: world
    debug: false
    events:
        after delta time secondly:
        - define per_second <script[scoreboard_data].parsed_key[refresh rate]>
        - define interval <element[1].div[<[per_second]>]>
        - repeat <[per_second]>:
            - run scoreboard_main_runner_task
            - wait <[interval]>
scoreboard_main_runner_task:
    type: task
    debug: false
    script:
    - foreach <server.online_players> as:__player:
        - run scoreboard_process_scoreboard_task
scoreboard_process_animations_proc:
    type: procedure
    debug: false
    definitions: player|lines|animation_interval
    script:
    - define rate <element[1].div[<[animation_interval].in_seconds>]>
    - define count <[lines].size>
    - define index <util.current_time_millis.div[1000].mul[<[rate]>].round.mod[<[count]>].add[1]>
    - determine <[lines].get[<[index]>].parsed>

scoreboard_process_lines_proc:
    type: procedure
    debug: false
    definitions: preset
    script:
    - if <script[scoreboard_data].list_keys[presets]> !contains <[preset]>:
        - debug error "The preset '<[preset]>' is missing!"
        - stop

    - define title_data <script[scoreboard_data].data_key[presets.<[preset]>.title]>
    - define title_lines <[title_data.text].if_null[null]>
    - if <[title_lines]> == null:
        - debug error "The preset '<[preset]>' has a missing title text!"
        - stop
    - define title_animation_interval <duration[<[title_data.animation interval].if_null[1s]>]>
    - define title <player.proc[scoreboard_process_animations_proc].context[<list_single[<[title_lines]>].include_single[<[title_animation_interval]>]>]>

    - define lines <script[scoreboard_data].data_key[presets.<[preset]>.lines].filter_tag[<[filter_value.conditions].if_null[<list>].parse[parsed.not].filter[].is_empty>]>

    - define output_lines <list>
    - foreach <[lines]> key:line_name as:line:
        - define text <[line.text].if_null[null]>
        - if <[text]> == null:
            - debug error "The preset '<[preset]>' has an invalid line at <[line_name]> - missing text key! Skipping..."
            - foreach next
        - if <[text].size> <= 1:
            - define output_lines:->:<[text].get[1].parsed>
            - foreach next
        - if <[line.has animation].if_null[false]>:
            - define animation_interval <duration[<[line.animation interval].if_null[1s]>]>
            - define output_lines:->:<player.proc[scoreboard_process_animations_proc].context[<list_single[<[text]>].include_single[<[animation_interval]>]>]>
        - else:
            - define output_lines <[output_lines].include[<[text].parse[parsed]>]>
    - definemap output_map:
            title: <[title]>
            lines: <[output_lines]>
    - determine <[output_map]>
######################
