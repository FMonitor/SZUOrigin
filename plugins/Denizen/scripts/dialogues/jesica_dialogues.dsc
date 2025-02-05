jesica_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    jesica:
        jesica_icon: <element[<&chr[e382]>].font[minecraft:dialogue_icons].color[white]>
        jesica_name: Jesica
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        jesica1: Hello there traveler. I'd
        jesica2: be delighted to help you
        jesica3: on your journey.


jesica_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_jesica:
        - run talking_to_jesica
        on player left clicks air flagged:talking_to_jesica:
        - run talking_to_jesica
        on player steps on block flagged:talking_to_jesica:
        - run talking_to_jesica

talking_to_jesica:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_jesica]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_jesica:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_jesica_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_jesica_interact
npc_jesica_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[36].font[utility:spacing]>
                    - define d_frame <script[jesica_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_jesica_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define jesica_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define jesica_icon <script[jesica_npc_dialogue].parsed_key[jesica.jesica_icon]>
                    - define icon <[jesica_space_icon]><[jesica_icon]>
                    #██NAME
                    - define jesica_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define jesica_name_get <script[jesica_npc_dialogue].parsed_key[jesica.jesica_name]>
                    - define jesica_name_color <element[<[jesica_name_get]>].color[GOLD].font[lore_line1]>
                    - define jesica_name <[jesica_name_space]><[jesica_name_color]>
                    #██Line 1
                    - define jesica_d1_space <proc[negative_spacing].context[25].font[utility:spacing]>
                    - define jesica_d1_get <script[jesica_npc_dialogue].parsed_key[jesica.jesica1]>
                    - define jesica_d1_color <element[<[jesica_d1_get]>].color[WHITE].font[lore_line2]>
                    - define jesica_d1 <[jesica_d1_space]><[jesica_d1_color]>
                    #██Line 2
                    - define jesica_d2_space <proc[negative_spacing].context[87].font[utility:spacing]>
                    - define jesica_d2_get <script[jesica_npc_dialogue].parsed_key[jesica.jesica2]>
                    - define jesica_d2_color <element[<[jesica_d2_get]>].color[WHITE].font[lore_line3]>
                    - define jesica_d2 <[jesica_d2_space]><[jesica_d2_color]>
                    #██Line 3
                    - define jesica_d3_space <proc[negative_spacing].context[88].font[utility:spacing]>
                    - define jesica_d3_get <script[jesica_npc_dialogue].parsed_key[jesica.jesica3]>
                    - define jesica_d3_color <element[<[jesica_d3_get]>].color[WHITE].font[lore_line4]>
                    - define jesica_d3 <[jesica_d3_space]><[jesica_d3_color]>
                    - if !<player.has_flag[talking_to_jesica]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_jesica
                        #██ Remove this flag to disable jesica dialogues"
                        - if <player.has_flag[talking_to_jesica]>:
                            - title "subtitle:<[d_jesica_frame]><[icon]> <[jesica_name]><[jesica_d1]><[jesica_d2]><[jesica_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_jesica
                        - bossshop menu
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_jesica]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_jesica:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop




