lore_builder:
    type: procedure
    definitions: linesize|lore
    debug: false
    script:
    - determine <[lore].separated_by[<n>].parsed.split_lines[<[linesize]>].lines_to_colored_list>
PlayerChatFormat:
    type: format
    debug: false
    format: <player.chat_prefix.parse_color> <player.name><white><&co> <[text]>

cinematic_scene:
    type: task
    debug: false
    script:
        - flag <player> cinematic_scene
        - if <player.has_flag[cinematic_scene]>:
            - fakeequip head:carved_pumpkin for:<player>

remove_cinematic_scene:
    type: task
    debug: false
    script:
        - if <player.has_flag[cinematic_scene]>:
            - flag <player> cinematic_scene:!
            - fakeequip head:carved_pumpkin for:<player> duration:2t