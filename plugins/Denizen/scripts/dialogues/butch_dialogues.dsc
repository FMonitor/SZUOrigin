butch_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    butch:
        butch_icon: <element[<&chr[e377]>].font[minecraft:dialogue_icons].color[white]>
        butch_name: Butch
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL [1---------------------23]
        butch1: We have a variety of pre-
        butch2: mium wools, Including merino,
        butch3: alpaca, and cashmere.


butch_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_butch:
        - run talking_to_butch
        on player left clicks air flagged:talking_to_butch:
        - run talking_to_butch
        on player steps on block flagged:talking_to_butch:
        - run talking_to_butch

talking_to_butch:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_butch]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_butch:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_butch_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_butch_interact
npc_butch_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[20].font[utility:spacing]>
                    - define d_frame <script[butch_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_butch_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define butch_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define butch_icon <script[butch_npc_dialogue].parsed_key[butch.butch_icon]>
                    - define icon <[butch_space_icon]><[butch_icon]>
                    #██NAME
                    - define butch_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define butch_name_get <script[butch_npc_dialogue].parsed_key[butch.butch_name]>
                    - define butch_name_color <element[<[butch_name_get]>].color[GOLD].font[lore_line1]>
                    - define butch_name <[butch_name_space]><[butch_name_color]>
                    #██Line 1
                    - define butch_d1_space <proc[negative_spacing].context[22].font[utility:spacing]>
                    - define butch_d1_get <script[butch_npc_dialogue].parsed_key[butch.butch1]>
                    - define butch_d1_color <element[<[butch_d1_get]>].color[WHITE].font[lore_line2]>
                    - define butch_d1 <[butch_d1_space]><[butch_d1_color]>
                    #██Line 2
                    - define butch_d2_space <proc[negative_spacing].context[96].font[utility:spacing]>
                    - define butch_d2_get <script[butch_npc_dialogue].parsed_key[butch.butch2]>
                    - define butch_d2_color <element[<[butch_d2_get]>].color[WHITE].font[lore_line3]>
                    - define butch_d2 <[butch_d2_space]><[butch_d2_color]>
                    #██Line 3
                    - define butch_d3_space <proc[negative_spacing].context[101].font[utility:spacing]>
                    - define butch_d3_get <script[butch_npc_dialogue].parsed_key[butch.butch3]>
                    - define butch_d3_color <element[<[butch_d3_get]>].color[WHITE].font[lore_line4]>
                    - define butch_d3 <[butch_d3_space]><[butch_d3_color]>
                    - if !<player.has_flag[talking_to_butch]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_butch
                        #██ Remove this flag to disable butch dialogues"
                        - if <player.has_flag[talking_to_butch]>:
                            - title "subtitle:<[d_butch_frame]><[icon]> <[butch_name]><[butch_d1]><[butch_d2]><[butch_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_butch
                        - bossshop shop_butch
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_butch]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_butch:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



