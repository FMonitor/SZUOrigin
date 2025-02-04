achilles_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    achilles:
        achilles_icon: <element[<&chr[e373]>].font[minecraft:dialogue_icons].color[white]>
        achilles_name: Achilles
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        achilles1: Curious Treasures you say?
        achilles2: What kind of treasures
        achilles3: are we talking about?


achilles_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_achilles:
        - run talking_to_achilles
        on player left clicks air flagged:talking_to_achilles:
        - run talking_to_achilles
        on player steps on block flagged:talking_to_achilles:
        - run talking_to_achilles

talking_to_achilles:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_achilles]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_achilles:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_achilles_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_achilles_interact
npc_achilles_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[16].font[utility:spacing]>
                    - define d_frame <script[achilles_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_achilles_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define achilles_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define achilles_icon <script[achilles_npc_dialogue].parsed_key[achilles.achilles_icon]>
                    - define icon <[achilles_space_icon]><[achilles_icon]>
                    #██NAME
                    - define achilles_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define achilles_name_get <script[achilles_npc_dialogue].parsed_key[achilles.achilles_name]>
                    - define achilles_name_color <element[<[achilles_name_get]>].color[GOLD].font[lore_line1]>
                    - define achilles_name <[achilles_name_space]><[achilles_name_color]>
                    #██Line 1
                    - define achilles_d1_space <proc[negative_spacing].context[29].font[utility:spacing]>
                    - define achilles_d1_get <script[achilles_npc_dialogue].parsed_key[achilles.achilles1]>
                    - define achilles_d1_color <element[<[achilles_d1_get]>].color[WHITE].font[lore_line2]>
                    - define achilles_d1 <[achilles_d1_space]><[achilles_d1_color]>
                    #██Line 2
                    - define achilles_d2_space <proc[negative_spacing].context[102].font[utility:spacing]>
                    - define achilles_d2_get <script[achilles_npc_dialogue].parsed_key[achilles.achilles2]>
                    - define achilles_d2_color <element[<[achilles_d2_get]>].color[WHITE].font[lore_line3]>
                    - define achilles_d2 <[achilles_d2_space]><[achilles_d2_color]>
                    #██Line 3
                    - define achilles_d3_space <proc[negative_spacing].context[82].font[utility:spacing]>
                    - define achilles_d3_get <script[achilles_npc_dialogue].parsed_key[achilles.achilles3]>
                    - define achilles_d3_color <element[<[achilles_d3_get]>].color[WHITE].font[lore_line4]>
                    - define achilles_d3 <[achilles_d3_space]><[achilles_d3_color]>
                    - if !<player.has_flag[talking_to_achilles]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_achilles
                        #██ Remove this flag to disable achilles dialogues"
                        - if <player.has_flag[talking_to_achilles]>:
                            - title "subtitle:<[d_achilles_frame]><[icon]> <[achilles_name]><[achilles_d1]><[achilles_d2]><[achilles_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_achilles
                        - bossshop shop_achilles
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_achilles]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_achilles:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



