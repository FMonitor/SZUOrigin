gatekeeper_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    gatekeeper:
        gatekeeper_icon: <element[<&chr[e380]>].font[minecraft:dialogue_icons].color[white]>
        gatekeeper_name: Gatekeeper
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        gatekeeper1: I need a guardian to se-
        gatekeeper2: cure my fortress. What
        gatekeeper3: do you have to offer?


gatekeeper_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_gatekeeper:
        - run talking_to_gatekeeper
        on player left clicks air flagged:talking_to_gatekeeper:
        - run talking_to_gatekeeper
        on player steps on block flagged:talking_to_gatekeeper:
        - run talking_to_gatekeeper

talking_to_gatekeeper:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_gatekeeper]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_gatekeeper:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_gatekeeper_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_gatekeeper_interact
npc_gatekeeper_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[20].font[utility:spacing]>
                    - define d_frame <script[gatekeeper_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_gatekeeper_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define gatekeeper_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define gatekeeper_icon <script[gatekeeper_npc_dialogue].parsed_key[gatekeeper.gatekeeper_icon]>
                    - define icon <[gatekeeper_space_icon]><[gatekeeper_icon]>
                    #██NAME
                    - define gatekeeper_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define gatekeeper_name_get <script[gatekeeper_npc_dialogue].parsed_key[gatekeeper.gatekeeper_name]>
                    - define gatekeeper_name_color <element[<[gatekeeper_name_get]>].color[GOLD].font[lore_line1]>
                    - define gatekeeper_name <[gatekeeper_name_space]><[gatekeeper_name_color]>
                    #██Line 1
                    - define gatekeeper_d1_space <proc[negative_spacing].context[40].font[utility:spacing]>
                    - define gatekeeper_d1_get <script[gatekeeper_npc_dialogue].parsed_key[gatekeeper.gatekeeper1]>
                    - define gatekeeper_d1_color <element[<[gatekeeper_d1_get]>].color[WHITE].font[lore_line2]>
                    - define gatekeeper_d1 <[gatekeeper_d1_space]><[gatekeeper_d1_color]>
                    #██Line 2
                    - define gatekeeper_d2_space <proc[negative_spacing].context[93].font[utility:spacing]>
                    - define gatekeeper_d2_get <script[gatekeeper_npc_dialogue].parsed_key[gatekeeper.gatekeeper2]>
                    - define gatekeeper_d2_color <element[<[gatekeeper_d2_get]>].color[WHITE].font[lore_line3]>
                    - define gatekeeper_d2 <[gatekeeper_d2_space]><[gatekeeper_d2_color]>
                    #██Line 3
                    - define gatekeeper_d3_space <proc[negative_spacing].context[83].font[utility:spacing]>
                    - define gatekeeper_d3_get <script[gatekeeper_npc_dialogue].parsed_key[gatekeeper.gatekeeper3]>
                    - define gatekeeper_d3_color <element[<[gatekeeper_d3_get]>].color[WHITE].font[lore_line4]>
                    - define gatekeeper_d3 <[gatekeeper_d3_space]><[gatekeeper_d3_color]>
                    - if !<player.has_flag[talking_to_gatekeeper]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_gatekeeper
                        #██ Remove this flag to disable gatekeeper dialogues"
                        - if <player.has_flag[talking_to_gatekeeper]>:
                            - title "subtitle:<[d_gatekeeper_frame]><[icon]> <[gatekeeper_name]><[gatekeeper_d1]><[gatekeeper_d2]><[gatekeeper_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_gatekeeper
                        - bossshop shop_gatekeeper
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_gatekeeper]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_gatekeeper:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



