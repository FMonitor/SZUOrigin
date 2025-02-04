forester_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    forester:
        forester_icon: <element[<&chr[e379]>].font[minecraft:dialogue_icons].color[white]>
        forester_name: Forester
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        forester1: Efficiency will save me a
        forester2: lot of time. Please add it
        forester3: to all three axes.


forester_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_forester:
        - run talking_to_forester
        on player left clicks air flagged:talking_to_forester:
        - run talking_to_forester
        on player steps on block flagged:talking_to_forester:
        - run talking_to_forester

talking_to_forester:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_forester]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_forester:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_forester_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_forester_interact
npc_forester_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[40].font[utility:spacing]>
                    - define d_frame <script[forester_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_forester_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define forester_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define forester_icon <script[forester_npc_dialogue].parsed_key[forester.forester_icon]>
                    - define icon <[forester_space_icon]><[forester_icon]>
                    #██NAME
                    - define forester_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define forester_name_get <script[forester_npc_dialogue].parsed_key[forester.forester_name]>
                    - define forester_name_color <element[<[forester_name_get]>].color[GOLD].font[lore_line1]>
                    - define forester_name <[forester_name_space]><[forester_name_color]>
                    #██Line 1
                    - define forester_d1_space <proc[negative_spacing].context[34].font[utility:spacing]>
                    - define forester_d1_get <script[forester_npc_dialogue].parsed_key[forester.forester1]>
                    - define forester_d1_color <element[<[forester_d1_get]>].color[WHITE].font[lore_line2]>
                    - define forester_d1 <[forester_d1_space]><[forester_d1_color]>
                    #██Line 2
                    - define forester_d2_space <proc[negative_spacing].context[88].font[utility:spacing]>
                    - define forester_d2_get <script[forester_npc_dialogue].parsed_key[forester.forester2]>
                    - define forester_d2_color <element[<[forester_d2_get]>].color[WHITE].font[lore_line3]>
                    - define forester_d2 <[forester_d2_space]><[forester_d2_color]>
                    #██Line 3
                    - define forester_d3_space <proc[negative_spacing].context[90].font[utility:spacing]>
                    - define forester_d3_get <script[forester_npc_dialogue].parsed_key[forester.forester3]>
                    - define forester_d3_color <element[<[forester_d3_get]>].color[WHITE].font[lore_line4]>
                    - define forester_d3 <[forester_d3_space]><[forester_d3_color]>
                    - if !<player.has_flag[talking_to_forester]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_forester
                        #██ Remove this flag to disable forester dialogues"
                        - if <player.has_flag[talking_to_forester]>:
                            - title "subtitle:<[d_forester_frame]><[icon]> <[forester_name]><[forester_d1]><[forester_d2]><[forester_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_forester
                        - bossshop shop_forester
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_forester]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_forester:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



