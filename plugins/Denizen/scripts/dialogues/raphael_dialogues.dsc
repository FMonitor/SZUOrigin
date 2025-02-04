raphael_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    raphael:
        raphael_icon: <element[<&chr[e384]>].font[minecraft:dialogue_icons].color[white]>
        raphael_name: Raphael
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL     [------------------------]
        raphael1: Need some iron and diamond
        raphael2: to craft the finest gear
        raphael3: for my next expedition.


raphael_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_raphael:
        - run talking_to_raphael
        on player left clicks air flagged:talking_to_raphael:
        - run talking_to_raphael
        on player steps on block flagged:talking_to_raphael:
        - run talking_to_raphael

talking_to_raphael:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_raphael]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_raphael:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_raphael_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_raphael_interact
npc_raphael_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[20].font[utility:spacing]>
                    - define d_frame <script[raphael_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_raphael_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define raphael_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define raphael_icon <script[raphael_npc_dialogue].parsed_key[raphael.raphael_icon]>
                    - define icon <[raphael_space_icon]><[raphael_icon]>
                    #██NAME
                    - define raphael_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define raphael_name_get <script[raphael_npc_dialogue].parsed_key[raphael.raphael_name]>
                    - define raphael_name_color <element[<[raphael_name_get]>].color[GOLD].font[lore_line1]>
                    - define raphael_name <[raphael_name_space]><[raphael_name_color]>
                    #██Line 1
                    - define raphael_d1_space <proc[negative_spacing].context[29].font[utility:spacing]>
                    - define raphael_d1_get <script[raphael_npc_dialogue].parsed_key[raphael.raphael1]>
                    - define raphael_d1_color <element[<[raphael_d1_get]>].color[WHITE].font[lore_line2]>
                    - define raphael_d1 <[raphael_d1_space]><[raphael_d1_color]>
                    #██Line 2
                    - define raphael_d2_space <proc[negative_spacing].context[100].font[utility:spacing]>
                    - define raphael_d2_get <script[raphael_npc_dialogue].parsed_key[raphael.raphael2]>
                    - define raphael_d2_color <element[<[raphael_d2_get]>].color[WHITE].font[lore_line3]>
                    - define raphael_d2 <[raphael_d2_space]><[raphael_d2_color]>
                    #██Line 3
                    - define raphael_d3_space <proc[negative_spacing].context[88].font[utility:spacing]>
                    - define raphael_d3_get <script[raphael_npc_dialogue].parsed_key[raphael.raphael3]>
                    - define raphael_d3_color <element[<[raphael_d3_get]>].color[WHITE].font[lore_line4]>
                    - define raphael_d3 <[raphael_d3_space]><[raphael_d3_color]>
                    - if !<player.has_flag[talking_to_raphael]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_raphael
                        #██ Remove this flag to disable raphael dialogues"
                        - if <player.has_flag[talking_to_raphael]>:
                            - title "subtitle:<[d_raphael_frame]><[icon]> <[raphael_name]><[raphael_d1]><[raphael_d2]><[raphael_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_raphael
                        - bossshop shop_raphael
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_raphael]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_raphael:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



