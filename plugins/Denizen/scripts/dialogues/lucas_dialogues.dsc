lucas_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    lucas:
        lucas_icon: <element[<&chr[e383]>].font[minecraft:dialogue_icons].color[white]>
        lucas_name: Lucas
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL     [------------------------]
        lucas1: The climate here is perfect
        lucas2: for corn, of treasures are
        lucas3: we talking about?


lucas_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_lucas:
        - run talking_to_lucas
        on player left clicks air flagged:talking_to_lucas:
        - run talking_to_lucas
        on player steps on block flagged:talking_to_lucas:
        - run talking_to_lucas

talking_to_lucas:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_lucas]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_lucas:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_lucas_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_lucas_interact
npc_lucas_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[40].font[utility:spacing]>
                    - define d_frame <script[lucas_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_lucas_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define lucas_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define lucas_icon <script[lucas_npc_dialogue].parsed_key[lucas.lucas_icon]>
                    - define icon <[lucas_space_icon]><[lucas_icon]>
                    #██NAME
                    - define lucas_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define lucas_name_get <script[lucas_npc_dialogue].parsed_key[lucas.lucas_name]>
                    - define lucas_name_color <element[<[lucas_name_get]>].color[GOLD].font[lore_line1]>
                    - define lucas_name <[lucas_name_space]><[lucas_name_color]>
                    #██Line 1
                    - define lucas_d1_space <proc[negative_spacing].context[23].font[utility:spacing]>
                    - define lucas_d1_get <script[lucas_npc_dialogue].parsed_key[lucas.lucas1]>
                    - define lucas_d1_color <element[<[lucas_d1_get]>].color[WHITE].font[lore_line2]>
                    - define lucas_d1 <[lucas_d1_space]><[lucas_d1_color]>
                    #██Line 2
                    - define lucas_d2_space <proc[negative_spacing].context[99].font[utility:spacing]>
                    - define lucas_d2_get <script[lucas_npc_dialogue].parsed_key[lucas.lucas2]>
                    - define lucas_d2_color <element[<[lucas_d2_get]>].color[WHITE].font[lore_line3]>
                    - define lucas_d2 <[lucas_d2_space]><[lucas_d2_color]>
                    #██Line 3
                    - define lucas_d3_space <proc[negative_spacing].context[99].font[utility:spacing]>
                    - define lucas_d3_get <script[lucas_npc_dialogue].parsed_key[lucas.lucas3]>
                    - define lucas_d3_color <element[<[lucas_d3_get]>].color[WHITE].font[lore_line4]>
                    - define lucas_d3 <[lucas_d3_space]><[lucas_d3_color]>
                    - if !<player.has_flag[talking_to_lucas]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_lucas
                        #██ Remove this flag to disable lucas dialogues"
                        - if <player.has_flag[talking_to_lucas]>:
                            - title "subtitle:<[d_lucas_frame]><[icon]> <[lucas_name]><[lucas_d1]><[lucas_d2]><[lucas_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_lucas
                        - bossshop shop_lucas
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_lucas]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_lucas:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



