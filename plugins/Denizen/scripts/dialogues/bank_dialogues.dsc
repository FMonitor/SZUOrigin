bank_teller_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    bank_teller:
        #Element must contain a maximum or not more than 46 characters
        bank_teller_icon: <element[<&chr[e371]>].font[minecraft:dialogue_icons].color[white]>
        bank_teller_name: Teller
        bank_teller1: Hello, you'r here to deposit
        bank_teller2: something to your account.
bank_teller_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_bank_teller:
        - run talking_to_bank_teller
        on player left clicks air flagged:talking_to_bank_teller:
        - run talking_to_bank_teller
        on player steps on block flagged:talking_to_bank_teller:
        - run talking_to_bank_teller

talking_to_bank_teller:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_bank_teller]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_bank_teller:!
            - flag <player> bank_tutorial_2:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - actionbar " " targets:<player>
            - stop

npc_bank_teller_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:1
    interact scripts:
    - npc_bank_teller_interact
npc_bank_teller_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define d_frame <script[bank_teller_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_teller_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define teller_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define teller_icon <script[bank_teller_npc_dialogue].parsed_key[bank_teller.bank_teller_icon]>
                    - define bank_icon <[teller_space_icon]><[teller_icon]>
                    #██NAME
                    - define teller_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define teller_name_get <script[bank_teller_npc_dialogue].parsed_key[bank_teller.bank_teller_name]>
                    - define teller_name_color <element[<[teller_name_get]>].color[GOLD].font[lore_line1]>
                    - define teller_name <[teller_name_space]><[teller_name_color]>
                    #██Line 1
                    - define teller_d1_space <proc[negative_spacing].context[22].font[utility:spacing]>
                    - define teller_d1_get <script[bank_teller_npc_dialogue].parsed_key[bank_teller.bank_teller1]>
                    - define teller_d1_color <element[<[teller_d1_get]>].color[WHITE].font[lore_line2]>
                    - define teller_d1 <[teller_d1_space]><[teller_d1_color]>
                    #██Line 2
                    - define teller_d2_space <proc[negative_spacing].context[100].font[utility:spacing]>
                    - define teller_d2_get <script[bank_teller_npc_dialogue].parsed_key[bank_teller.bank_teller2]>
                    - define teller_d2_color <element[<[teller_d2_get]>].color[WHITE].font[lore_line3]>
                    - define teller_d2 <[teller_d2_space]><[teller_d2_color]>
                    - flag <player> talking_to_bank_teller
                    - if <player.has_flag[talking_to_bank_teller]>:
                        - if !<player.has_flag[teller_give_coins]>:
                            - adjust <player> fov_multiplier:1
                            - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                            - flag <player> bank_tutorial_2
                            - fakeequip head:carved_pumpkin for:<player>
                            #██ Remove this flag to give another coins  to the player "flag <player> teller_give_coins:!"
                            - flag <player> teller_give_coins
                            - give coins_item quantity:16
                            - flag <player> nbarvigating:!
                            - if <player.has_flag[bank_tutorial_2]>:
                                - title "subtitle:<[d_teller_frame]><[bank_icon]> <[teller_name]><[teller_d1]><[teller_d2]> " fade_in:0s stay:1s fade_out:10t
                            - wait 30t
                            - inventory open destination:coins_inventory

                        - else:
                            - adjust <player> fov_multiplier:1
                            - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                            - fakeequip head:carved_pumpkin for:<player>
                            - title "subtitle:<[d_teller_frame]><[bank_icon]> <[teller_name]><[teller_d1]><[teller_d2]> " fade_in:0s stay:1s fade_out:10t
                            - wait 30t
                            - inventory open destination:coins_inventory


            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_bank_teller]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_bank_teller:!
                        - flag <player> bank_tutorial_2:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - actionbar " " targets:<player>
                        - stop
