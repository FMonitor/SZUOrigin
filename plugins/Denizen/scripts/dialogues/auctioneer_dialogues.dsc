auctioneer_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    auctioneer:
        auctioneer_icon: <element[<&chr[e376]>].font[minecraft:dialogue_icons].color[white]>
        auctioneer_name: Auctioneer
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        auctioneer1: I've heard there's a
        auctioneer2: egg on the block today.
        auctioneer3: I must have it!


auctioneer_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_auctioneer:
        - run talking_to_auctioneer
        on player left clicks air flagged:talking_to_auctioneer:
        - run talking_to_auctioneer
        on player steps on block flagged:talking_to_auctioneer:
        - run talking_to_auctioneer

talking_to_auctioneer:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_auctioneer]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_auctioneer:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_auctioneer_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_auctioneer_interact
npc_auctioneer_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[50].font[utility:spacing]>
                    - define d_frame <script[auctioneer_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_auctioneer_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define auctioneer_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define auctioneer_icon <script[auctioneer_npc_dialogue].parsed_key[auctioneer.auctioneer_icon]>
                    - define icon <[auctioneer_space_icon]><[auctioneer_icon]>
                    #██NAME
                    - define auctioneer_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define auctioneer_name_get <script[auctioneer_npc_dialogue].parsed_key[auctioneer.auctioneer_name]>
                    - define auctioneer_name_color <element[<[auctioneer_name_get]>].color[GOLD].font[lore_line1]>
                    - define auctioneer_name <[auctioneer_name_space]><[auctioneer_name_color]>
                    #██Line 1
                    - define auctioneer_d1_space <proc[negative_spacing].context[39].font[utility:spacing]>
                    - define auctioneer_d1_get <script[auctioneer_npc_dialogue].parsed_key[auctioneer.auctioneer1]>
                    - define auctioneer_d1_color <element[<[auctioneer_d1_get]>].color[WHITE].font[lore_line2]>
                    - define auctioneer_d1 <[auctioneer_d1_space]><[auctioneer_d1_color]>
                    #██Line 2
                    - define auctioneer_d2_space <proc[negative_spacing].context[74].font[utility:spacing]>
                    - define auctioneer_d2_get <script[auctioneer_npc_dialogue].parsed_key[auctioneer.auctioneer2]>
                    - define auctioneer_d2_color <element[<[auctioneer_d2_get]>].color[WHITE].font[lore_line3]>
                    - define auctioneer_d2 <[auctioneer_d2_space]><[auctioneer_d2_color]>
                    #██Line 3
                    - define auctioneer_d3_space <proc[negative_spacing].context[85].font[utility:spacing]>
                    - define auctioneer_d3_get <script[auctioneer_npc_dialogue].parsed_key[auctioneer.auctioneer3]>
                    - define auctioneer_d3_color <element[<[auctioneer_d3_get]>].color[WHITE].font[lore_line4]>
                    - define auctioneer_d3 <[auctioneer_d3_space]><[auctioneer_d3_color]>
                    - if !<player.has_flag[talking_to_auctioneer]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_auctioneer
                        #██ Remove this flag to disable auctioneer dialogues"
                        - if <player.has_flag[talking_to_auctioneer]>:
                            - title "subtitle:<[d_auctioneer_frame]><[icon]> <[auctioneer_name]><[auctioneer_d1]><[auctioneer_d2]><[auctioneer_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - execute as_op "ah" silent
                        - bossshop shop_auctioneer
                    - else:
                        - execute as_op "ah" silent
                        - playsound <player> custom sound:custom.sound.select_dialogue volume:1
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_auctioneer]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_auctioneer:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



