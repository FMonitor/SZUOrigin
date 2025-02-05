sidebar_on_join:
    type: world
    debug: false
    events:
        after resource pack status status:SUCCESSFULLY_LOADED:
        - if !<player.has_flag[sidebar]>:
            - execute as_op "sidebar"
            - flag <player> sidebar
        - if !<player.has_flag[cinematic_intro]>:
            - if <player.location.world.name> == isla:
                - run dcutscene_animation_begin def.scene:intro def.player:<player> def.timespot:0s
                # - execute as_op "dcutscene play intro" silent
                #Remove this flag to replay the cinematic_intro flag <player> welcome_cinematic:!
                - flag <player> cinematic_intro
welcome_beach:
    type: task
    debug: false
    script:
    - midi file:welcome_beach
#noted
cuboid_note:
    type: world
    debug: false
    events:
        on server start:
        - define red_loons <cuboid[isla,56,84,157,53,86,157]>
        - define green_loons <cuboid[isla,217,83,60,217,85,63]>
        - define blue_loons <cuboid[isla,1,84,28,1,86,25]>
        - define yellow_loons <cuboid[isla,167,66,-140,170,68,-140]>
        - note <[red_loons]> as:red_balloon
        - note <[green_loons]> as:green_balloon
        - note <[blue_loons]> as:blue_balloon
        - note <[yellow_loons]> as:yellow_balloon
        - define tut_start_loc <cuboid[isla,60,82,145,49,85,137]>
        - note <[tut_start_loc]> as:start_tutorial
        - define crates_loca <cuboid[isla,39.6,87,108.5,30.5,82,85.5]>
        - note <[crates_loca]> as:crates_loc
        - define bank <cuboid[isla,8.5,89,44.5,15.5,83,48.5]>
        - note <[bank]> as:bank_loc
        - define library <cuboid[isla,92.5,90,44.5,114.5,84,24.5]>
        - note <[library]> as:library_loc
#Negative Spacing
negative_spacing:
  type: procedure
  debug: false
  definitions: int
  script:
    - if !<[int].is_integer>:
      - determine "Invalid integer"

    - define spacing <list>

    - while <[int]> > 0:
      - if <[int]> >= 1024:
        - define int:-:1024
        - define spacing <[spacing].include[<&chr[F80E]>]>
      - else if <[int]> >= 512:
        - define int:-:512
        - define spacing <[spacing].include[<&chr[F80D]>]>
      - else if <[int]> >= 128:
        - define int:-:128
        - define spacing <[spacing].include[<&chr[F80C]>]>
      - else if <[int]> >= 64:
        - define int:-:64
        - define spacing <[spacing].include[<&chr[F80B]>]>
      - else if <[int]> >= 32:
        - define int:-:32
        - define spacing <[spacing].include[<&chr[F80A]>]>
      - else if <[int]> >= 16:
        - define int:-:16
        - define spacing <[spacing].include[<&chr[F809]>]>
      - else if <[int]> >= 8:
        - define int:-:8
        - define spacing <[spacing].include[<&chr[F808]>]>
      - else if <[int]> >= 7:
        - define int:-:7
        - define spacing <[spacing].include[<&chr[F807]>]>
      - else if <[int]> >= 6:
        - define int:-:6
        - define spacing <[spacing].include[<&chr[F806]>]>
      - else if <[int]> >= 5:
        - define int:-:5
        - define spacing <[spacing].include[<&chr[F805]>]>
      - else if <[int]> >= 4:
        - define int:-:4
        - define spacing <[spacing].include[<&chr[F804]>]>
      - else if <[int]> >= 3:
        - define int:-:3
        - define spacing <[spacing].include[<&chr[F803]>]>
      - else if <[int]> >= 2:
        - define int:-:2
        - define spacing <[spacing].include[<&chr[F802]>]>
      - else:
        - define int:-:1
        - define spacing <[spacing].include[<&chr[F801]>]>

    - determine <[spacing].unseparated>

positive_spacing:
  type: procedure
  debug: false
  definitions: int
  script:
    - if !<[int].is_integer>:
      - determine "Invalid integer"
    - define spacing <list>
    - while <[int]> > 0:
      - if <[int]> >= 1024:
        - define int:-:1024
        - define spacing <[spacing].include[<&chr[F82E]>]>
      - else if <[int]> >= 512:
        - define int:-:512
        - define spacing <[spacing].include[<&chr[F82D]>]>
      - else if <[int]> >= 128:
        - define int:-:128
        - define spacing <[spacing].include[<&chr[F82C]>]>
      - else if <[int]> >= 64:
        - define int:-:64
        - define spacing <[spacing].include[<&chr[F82B]>]>
      - else if <[int]> >= 32:
        - define int:-:32
        - define spacing <[spacing].include[<&chr[F82A]>]>
      - else if <[int]> >= 16:
        - define int:-:16
        - define spacing <[spacing].include[<&chr[F829]>]>
      - else if <[int]> >= 8:
        - define int:-:8
        - define spacing <[spacing].include[<&chr[F828]>]>
      - else if <[int]> >= 7:
        - define int:-:7
        - define spacing <[spacing].include[<&chr[F827]>]>
      - else if <[int]> >= 6:
        - define int:-:6
        - define spacing <[spacing].include[<&chr[F826]>]>
      - else if <[int]> >= 5:
        - define int:-:5
        - define spacing <[spacing].include[<&chr[F825]>]>
      - else if <[int]> >= 4:
        - define int:-:4
        - define spacing <[spacing].include[<&chr[F824]>]>
      - else if <[int]> >= 3:
        - define int:-:3
        - define spacing <[spacing].include[<&chr[F823]>]>
      - else if <[int]> >= 2:
        - define int:-:2
        - define spacing <[spacing].include[<&chr[F822]>]>
      - else:
        - define int:-:1
        - define spacing <[spacing].include[<&chr[F821]>]>

    - determine <[spacing].unseparated>


#DO NOT TOUCH ANYTHING HERE UNLESS YOU KNOW WHAT ARE YOU DOING!
progress_bar_data:
    type: data
    # Per second
    update_frequency: 2
    default_bar:
        from: 0
        to: 10
        value: 0
        characters:
            full:
                left: <&font[mcbars:sharp_bar]>L<script[icons].parsed_key[spaces.1]>
                middle: <&font[mcbars:sharp_bar]>M<script[icons].parsed_key[spaces.1]>
                right: <&font[mcbars:sharp_bar]>R<script[icons].parsed_key[spaces.1]>
            empty:
                left: <&font[mcbars:sharp_bar]>l<script[icons].parsed_key[spaces.1]>
                middle: <&font[mcbars:sharp_bar]>m<script[icons].parsed_key[spaces.1]>
                right: <&font[mcbars:sharp_bar]>r<script[icons].parsed_key[spaces.1]>
            cursor:
                left: <&font[mcbars:sharp_bar]>0<script[icons].parsed_key[spaces.1]>
                middle: <&font[mcbars:sharp_bar]>1<script[icons].parsed_key[spaces.1]>
                right: <&font[mcbars:sharp_bar]>2<script[icons].parsed_key[spaces.1]>
        cursor: false
    bars:
        entity:
            health:
                from: 0
                to: <[entity].health_max>
                value: <[entity].health>
                length: 10
        server:
            ram:
                from: 0
                to: <util.ram_allocated>
                value: <util.ram_usage>
                length: 10
            tps:
                from: 0
                to: 20
                value: <server.recent_tps.get[1]>
                length: 10
                cursor: true
        player:
            health:
                from: 0
                to: <player.health_max>
                value: <player.health>
                length: 10
                #cursor: true
            hunger:
                from: 0
                to: 20
                value: <player.food_level>
                length: 10

the_progress_bar_update_world:
    type: world
    debug: false
    events:
        on delta time secondly:
        - define frequency <script[progress_bar_data].parsed_key[update_frequency]>
        - define interval <element[1].div[<[frequency]>]>
        - repeat <[frequency]>:
            - run the_progress_bar_update_task
            - wait <[interval]>

the_progress_bar_update_entity_task:
    type: task
    debug: false
    definitions: entity
    script:
    - foreach <script[progress_bar_data].data_key[bars.entity].keys> as:bar_preset:
        - flag <[entity]> the_progress_bar.<[bar_preset]>:<proc[the_progress_bar_from_preset_proc].context[<list_single[entity].include_single[<[bar_preset]>].include_single[<[entity]>]>]>

the_progress_bar_update_task:
    type: task
    debug: false
    script:
    - foreach <server.online_players> as:__player:
        - foreach <script[progress_bar_data].data_key[bars.player].keys> as:bar_preset:
            - flag <player> the_progress_bar.<[bar_preset]>:<proc[the_progress_bar_from_preset_proc].context[player|<[bar_preset]>]>

    - foreach <script[progress_bar_data].data_key[bars.server].keys> as:bar_preset:
        - flag server the_progress_bar.<[bar_preset]>:<proc[the_progress_bar_from_preset_proc].context[server|<[bar_preset]>]>

the_progress_bar_from_preset_proc:
    type: procedure
    debug: false
    definitions: type|preset|entity
    script:
    - define bar_data <script[progress_bar_data].parsed_key[default_bar]>
    - choose <[type]>:
        - case entity:
            - define override <script[progress_bar_data].parsed_key[bars.entity.<[preset]>]>
        - case server:
            - define override <script[progress_bar_data].parsed_key[bars.server.<[preset]>]>
        - case player:
            - define override <script[progress_bar_data].parsed_key[bars.player.<[preset]>]>
    - foreach <[override].deep_keys> as:key:
        - define bar_data <[bar_data].deep_with[<[key]>].as[<[override].deep_get[<[key]>]>]>

    - define bar <proc[the_progress_bar_proc].context[<list[<[bar_data.from].if_null[0]>|<[bar_data.to].if_null[10]>|<[bar_data.value].if_null[0]>|<[bar_data.length].if_null[10]>].include_single[<[bar_data.characters]>].include_single[<[bar_data.cursor].if_null[false]>]>]>

    - determine <[bar]>
the_progress_bar_proc:
    type: procedure
    debug: false
    definitions: from|to|value|length|characters|cursor
    script:
    - define bar <empty>
    - define progress <[value].sub[<[from]>].div[<[from].add[<[to]>]>].min[1].if_null[1]>
    - define progress_fixed <[progress].mul[<[length]>].round>
    # Progress > 0 - add full characters
    - if <[progress_fixed]> > 0:
        # Adds empty characters + cursor
        - if <[cursor]>:
            - if <[progress_fixed]> == 1:
                - define bar <[bar]><[characters.cursor.left]>
                - define bar <[bar]><[characters.empty.middle].repeat[<[progress_fixed].sub[1].max[0]>]>
            - else:
                - define bar <[bar]><[characters.empty.left]>
                - define bar <[bar]><[characters.empty.middle].repeat[<[progress_fixed].sub[2].max[0]>]>
                - define bar <[bar]><[characters.cursor.middle]>
        - else:
            - define bar <[bar]><[characters.full.left]>
            - define bar <[bar]><[characters.full.middle].repeat[<[progress_fixed].sub[1]>]>

    # Add empty characters
    - if <[progress_fixed]> == 0:
        - if <[cursor]>:
            - define bar <[bar]><[characters.cursor.left]>
        - else:
            - define bar <[bar]><[characters.empty.left]>
        - define bar <[bar]><[characters.empty.middle].repeat[<[length].sub[<[progress_fixed]>].sub[2].max[0]>]>
    - else:
        - define bar <[bar]><[characters.empty.middle].repeat[<[length].sub[<[progress_fixed]>].sub[1].max[0]>]>

    # Progress = length - add full right character, replacing the last full middle character
    - if <[progress_fixed]> == <[length]>:
        - if <[cursor]>:
            - define bar <[bar].before_last[<[characters.cursor.middle]>]><[characters.cursor.right]>
        - else:
            - define bar <[bar].before_last[<[characters.full.middle]>]><[characters.full.right]>
    - else:
        - define bar <[bar]><[characters.empty.right]>

    - determine <[bar]>

#####
entity_health_bars_data:
    type: data
    update_on_spawn: true
    update_ratelimit: 0.2s

    only_render_when_players_within_proximity: true
    render_proximity: 32

    has_timeout: true
    timeout: 5s

    disable_vanilla_name_tag: false

    y_offset: 1
    lines:
    - <[entity].custom_name.if_null[<[entity].translated_name>]>
    - <[entity].health.round.color[<color[red].with_hue[<[entity].health_percentage.mul[0.73].round>]>]>/<[entity].health_max.round.color[green]> <red>❤
    - <[entity].flag[the_progress_bar.health].color[<color[red].with_hue[<[entity].health_percentage.mul[0.73].round>]>]>

    entity_filter: "!player|armor_stand"

entity_health_bars_update_entity_bar_world:
    type: world
    debug: false
    events:
        after entity spawns:
        - if !<script[entity_health_bars_data].data_key[update_on_spawn]>:
            - stop
        - run entity_health_bars_update_bar_on_entity_task def.entity:<context.entity>
        after entity damaged bukkit_priority:monitor:
        - run entity_health_bars_update_bar_on_entity_task def.entity:<context.entity>

entity_health_bars_update_bar_on_entity_task:
    type: task
    debug: false
    definitions: entity
    script:
    - if <[entity].has_flag[entity_health_bars.bar_entity]>:
        - remove <[entity].flag[entity_health_bars.bar_entity]> if:<[entity].flag[entity_health_bars.bar_entity].is_spawned>
    - if !<[entity].is_living> || !<[entity].is_spawned>:
        - stop
    - if ( <script[entity_health_bars_data].data_key[only_render_when_players_within_proximity]> && <[entity].location.find_entities[player].within[<script[entity_health_bars_data].data_key[render_proximity]>].is_empty> ) || <[entity].has_flag[entity_health_bars.parent]>:
        - stop

    - if !<[entity].advanced_matches[<script[entity_health_bars_data].data_key[entity_filter]>]>:
        - stop

    - ratelimit <[entity]> <script[entity_health_bars_data].data_key[update_ratelimit]>
    - run the_progress_bar_update_entity_task def.entity:<[entity]>
    - define lines <script[entity_health_bars_data].parsed_key[lines]>

    - if <script[entity_health_bars_data].data_key[disable_vanilla_name_tag]>:
        - adjust <[entity]> custom_name_visible:false

    - define bar_entity <entity[text_display]>
    - adjust def:bar_entity text:<[lines].separated_by[<n>]>
    - adjust def:bar_entity pivot:center
    - adjust def:bar_entity see_through:false
    - adjust def:bar_entity opacity:255
    - adjust def:bar_entity background_color:0,0,0,0
    #- adjust def:bar_entity translation:0,<[entity].eye_height.add[<script[entity_health_bars_data].data_key[y_offset]>]>,0
    - spawn <[bar_entity]> <[entity].location.above[<[entity].eye_height.add[<script[entity_health_bars_data].data_key[y_offset]>]>]> save:entity
    #- mount <list_single[<entry[entity].spawned_entity>].include_single[<[entity]>]>
    - attach <entry[entity].spawned_entity> to:<[entity]> offset:0,<[entity].eye_height.add[<script[entity_health_bars_data].data_key[y_offset]>]>,0

    - flag <entry[entity].spawned_entity> entity_health_bars.parent:<[entity]>
    - define bar_entity <entry[entity].spawned_entity>

    - flag <[entity]> entity_health_bars.bar_entity:<[bar_entity]>
    - if <script[entity_health_bars_data].data_key[has_timeout]>:
        - wait <script[entity_health_bars_data].data_key[timeout]>
        - remove <[bar_entity]> if:<[bar_entity].is_spawned>

entity_health_bars_remove_bars:
    type: task
    debug: false
    definitions: entity
    script:
    - define e <[entity].flag[entity_health_bars.bar_entity].if_null[null]>
    - if <[e]> == null:
        - stop
    - remove <[e]> if:<[e].is_spawned>

entity_health_bars_remove_bars_on_despawn:
    type: world
    debug: false
    events:
        on entity dies:
        - run entity_health_bars_remove_bars def.entity:<context.entity>
        on entity despawns:
        - run entity_health_bars_remove_bars def.entity:<context.entity>

