antonio_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    antonio:
        antonio_icon: <element[<&chr[e375]>].font[minecraft:dialogue_icons].color[white]>
        antonio_name: Antonio
        #Element must contain a maximum or not more than 23 characters including spaces
        antonio1: If you ever need more
        antonio2: blocks, to your project
        antonio3: you know where to find me.


antonio_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_antonio:
        - run talking_to_antonio
        on player left clicks air flagged:talking_to_antonio:
        - run talking_to_antonio
        on player steps on block flagged:talking_to_antonio:
        - run talking_to_antonio

talking_to_antonio:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_antonio]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_antonio:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_antonio_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_antonio_interact
npc_antonio_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define d_frame <script[antonio_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_antonio_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define antonio_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define antonio_icon <script[antonio_npc_dialogue].parsed_key[antonio.antonio_icon]>
                    - define icon <[antonio_space_icon]><[antonio_icon]>
                    #██NAME
                    - define antonio_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define antonio_name_get <script[antonio_npc_dialogue].parsed_key[antonio.antonio_name]>
                    - define antonio_name_color <element[<[antonio_name_get]>].color[GOLD].font[lore_line1]>
                    - define antonio_name <[antonio_name_space]><[antonio_name_color]>
                    #██Line 1
                    - define antonio_d1_space <proc[negative_spacing].context[26].font[utility:spacing]>
                    - define antonio_d1_get <script[antonio_npc_dialogue].parsed_key[antonio.antonio1]>
                    - define antonio_d1_color <element[<[antonio_d1_get]>].color[WHITE].font[lore_line2]>
                    - define antonio_d1 <[antonio_d1_space]><[antonio_d1_color]>
                    #██Line 2
                    - define antonio_d2_space <proc[negative_spacing].context[82].font[utility:spacing]>
                    - define antonio_d2_get <script[antonio_npc_dialogue].parsed_key[antonio.antonio2]>
                    - define antonio_d2_color <element[<[antonio_d2_get]>].color[WHITE].font[lore_line3]>
                    - define antonio_d2 <[antonio_d2_space]><[antonio_d2_color]>
                    #██Line 3
                    - define antonio_d3_space <proc[negative_spacing].context[85].font[utility:spacing]>
                    - define antonio_d3_get <script[antonio_npc_dialogue].parsed_key[antonio.antonio3]>
                    - define antonio_d3_color <element[<[antonio_d3_get]>].color[WHITE].font[lore_line4]>
                    - define antonio_d3 <[antonio_d3_space]><[antonio_d3_color]>
                    - if !<player.has_flag[talking_to_antonio]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_antonio
                        #██ Remove this flag to disable antonio dialogues"
                        - if <player.has_flag[talking_to_antonio]>:
                            - title "subtitle:<[d_antonio_frame]><[icon]> <[antonio_name]><[antonio_d1]><[antonio_d2]><[antonio_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_antonio
                        - bossshop shop_antonio
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_antonio]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_antonio:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



