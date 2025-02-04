crist_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    crist:
        crist_icon: <element[<&chr[e378]>].font[minecraft:dialogue_icons].color[white]>
        crist_name: Crist
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL [1---------------------23]
        crist1: Welcome to <gold>Crates shop<reset>.
        crist2: You can open crates using
        crist3: <gold>crates keys<reset>.


crist_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_crist:
        - run talking_to_crist
        on player left clicks air flagged:talking_to_crist:
        - run talking_to_crist
        on player steps on block flagged:talking_to_crist:
        - run talking_to_crist

talking_to_crist:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_crist]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_crist:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_crist_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_crist_interact
npc_crist_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[54].font[utility:spacing]>
                    - define d_frame <script[crist_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_crist_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define crist_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define crist_icon <script[crist_npc_dialogue].parsed_key[crist.crist_icon]>
                    - define icon <[crist_space_icon]><[crist_icon]>
                    #██NAME
                    - define crist_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define crist_name_get <script[crist_npc_dialogue].parsed_key[crist.crist_name]>
                    - define crist_name_color <element[<[crist_name_get]>].color[GOLD].font[lore_line1]>
                    - define crist_name <[crist_name_space]><[crist_name_color]>
                    #██Line 1
                    - define crist_d1_space <proc[negative_spacing].context[20].font[utility:spacing]>
                    - define crist_d1_get <script[crist_npc_dialogue].parsed_key[crist.crist1]>
                    - define crist_d1_color <element[<[crist_d1_get]>].color[WHITE].font[lore_line2]>
                    - define crist_d1 <[crist_d1_space]><[crist_d1_color]>
                    #██Line 2
                    - define crist_d2_space <proc[negative_spacing].context[86].font[utility:spacing]>
                    - define crist_d2_get <script[crist_npc_dialogue].parsed_key[crist.crist2]>
                    - define crist_d2_color <element[<[crist_d2_get]>].color[WHITE].font[lore_line3]>
                    - define crist_d2 <[crist_d2_space]><[crist_d2_color]>
                    #██Line 3
                    - define crist_d3_space <proc[negative_spacing].context[97].font[utility:spacing]>
                    - define crist_d3_get <script[crist_npc_dialogue].parsed_key[crist.crist3]>
                    - define crist_d3_color <element[<[crist_d3_get]>].color[WHITE].font[lore_line4]>
                    - define crist_d3 <[crist_d3_space]><[crist_d3_color]>
                    - if !<player.has_flag[talking_to_crist]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - flag <player> talking_to_crist
                        - fakeequip head:carved_pumpkin for:<player>
                        #██ Remove this flag to disable crist dialogues"
                        - if <player.has_flag[talking_to_crist]>:
                            - title "subtitle:<[d_crist_frame]><[icon]> <[crist_name]><[crist_d1]><[crist_d2]><[crist_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - if !<player.has_flag[obtain_skey]>:
                            - flag <player> obtain_skey
                            - flag <player> nbarvigating:!
                            - execute as_op "crates key give <player.name> silver 1" silent
                            - narrate "<white><gray> You obtain a<gold> Silver key!"
                        - stop
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_crist]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_crist:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop