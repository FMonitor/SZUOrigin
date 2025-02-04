anchor_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    anchor:
        anchor_icon: <element[<&chr[e373]>].font[minecraft:dialogue_icons].color[white]>
        anchor_name: Anchor
        #Element must contain a maximum or not more than 23 characters including spaces
        anchor1: We have a rich variety of
        anchor2: fish here, including salmon,
        anchor3: trout, and halibut.


anchor_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_anchor:
        - run talking_to_anchor
        on player left clicks air flagged:talking_to_anchor:
        - run talking_to_anchor
        on player steps on block flagged:talking_to_anchor:
        - run talking_to_anchor

talking_to_anchor:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_anchor]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_anchor:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_anchor_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_anchor_interact
npc_anchor_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[30].font[utility:spacing]>
                    - define d_frame <script[anchor_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_anchor_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define anchor_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define anchor_icon <script[anchor_npc_dialogue].parsed_key[anchor.anchor_icon]>
                    - define icon <[anchor_space_icon]><[anchor_icon]>
                    #██NAME
                    - define anchor_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define anchor_name_get <script[anchor_npc_dialogue].parsed_key[anchor.anchor_name]>
                    - define anchor_name_color <element[<[anchor_name_get]>].color[GOLD].font[lore_line1]>
                    - define anchor_name <[anchor_name_space]><[anchor_name_color]>
                    #██Line 1
                    - define anchor_d1_space <proc[negative_spacing].context[26].font[utility:spacing]>
                    - define anchor_d1_get <script[anchor_npc_dialogue].parsed_key[anchor.anchor1]>
                    - define anchor_d1_color <element[<[anchor_d1_get]>].color[WHITE].font[lore_line2]>
                    - define anchor_d1 <[anchor_d1_space]><[anchor_d1_color]>
                    #██Line 2
                    - define anchor_d2_space <proc[negative_spacing].context[94].font[utility:spacing]>
                    - define anchor_d2_get <script[anchor_npc_dialogue].parsed_key[anchor.anchor2]>
                    - define anchor_d2_color <element[<[anchor_d2_get]>].color[WHITE].font[lore_line3]>
                    - define anchor_d2 <[anchor_d2_space]><[anchor_d2_color]>
                    #██Line 3
                    - define anchor_d3_space <proc[negative_spacing].context[97].font[utility:spacing]>
                    - define anchor_d3_get <script[anchor_npc_dialogue].parsed_key[anchor.anchor3]>
                    - define anchor_d3_color <element[<[anchor_d3_get]>].color[WHITE].font[lore_line4]>
                    - define anchor_d3 <[anchor_d3_space]><[anchor_d3_color]>
                    - if !<player.has_flag[talking_to_anchor]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_anchor
                        #██ Remove this flag to disable anchor dialogues"
                        - if <player.has_flag[talking_to_anchor]>:
                            - title "subtitle:<[d_anchor_frame]><[icon]> <[anchor_name]><[anchor_d1]><[anchor_d2]><[anchor_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_anchor
                        - bossshop shop_anchor
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_anchor]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_anchor:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



