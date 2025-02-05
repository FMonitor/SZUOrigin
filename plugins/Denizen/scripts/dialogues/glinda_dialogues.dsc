glinda_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    glinda:
        glinda_icon: <element[<&chr[e381]>].font[minecraft:dialogue_icons].color[white]>
        glinda_name: Glinda
        #Element must contain a maximum or not more than 23 characters including spaces
        #TO FILL   [------------------------]
        glinda1: I require the rarest and
        glinda2: most potent ingredients for
        glinda3: a powerful potion.


glinda_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_glinda:
        - run talking_to_glinda
        on player left clicks air flagged:talking_to_glinda:
        - run talking_to_glinda
        on player steps on block flagged:talking_to_glinda:
        - run talking_to_glinda

talking_to_glinda:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_glinda]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_glinda:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_glinda_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:2
    interact scripts:
    - npc_glinda_interact
npc_glinda_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[25].font[utility:spacing]>
                    - define d_frame <script[glinda_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_glinda_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define glinda_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define glinda_icon <script[glinda_npc_dialogue].parsed_key[glinda.glinda_icon]>
                    - define icon <[glinda_space_icon]><[glinda_icon]>
                    #██NAME
                    - define glinda_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define glinda_name_get <script[glinda_npc_dialogue].parsed_key[glinda.glinda_name]>
                    - define glinda_name_color <element[<[glinda_name_get]>].color[GOLD].font[lore_line1]>
                    - define glinda_name <[glinda_name_space]><[glinda_name_color]>
                    #██Line 1
                    - define glinda_d1_space <proc[negative_spacing].context[22].font[utility:spacing]>
                    - define glinda_d1_get <script[glinda_npc_dialogue].parsed_key[glinda.glinda1]>
                    - define glinda_d1_color <element[<[glinda_d1_get]>].color[WHITE].font[lore_line2]>
                    - define glinda_d1 <[glinda_d1_space]><[glinda_d1_color]>
                    #██Line 2
                    - define glinda_d2_space <proc[negative_spacing].context[91].font[utility:spacing]>
                    - define glinda_d2_get <script[glinda_npc_dialogue].parsed_key[glinda.glinda2]>
                    - define glinda_d2_color <element[<[glinda_d2_get]>].color[WHITE].font[lore_line3]>
                    - define glinda_d2 <[glinda_d2_space]><[glinda_d2_color]>
                    #██Line 3
                    - define glinda_d3_space <proc[negative_spacing].context[99].font[utility:spacing]>
                    - define glinda_d3_get <script[glinda_npc_dialogue].parsed_key[glinda.glinda3]>
                    - define glinda_d3_color <element[<[glinda_d3_get]>].color[WHITE].font[lore_line4]>
                    - define glinda_d3 <[glinda_d3_space]><[glinda_d3_color]>
                    - if !<player.has_flag[talking_to_glinda]>:
                        - adjust <player> fov_multiplier:1
                        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                        - fakeequip head:carved_pumpkin for:<player>
                        - flag <player> talking_to_glinda
                        #██ Remove this flag to disable glinda dialogues"
                        - if <player.has_flag[talking_to_glinda]>:
                            - title "subtitle:<[d_glinda_frame]><[icon]> <[glinda_name]><[glinda_d1]><[glinda_d2]><[glinda_d3]> " fade_in:0s stay:35t fade_out:5t
                        - wait 40t
                        - run talking_to_glinda
                        - bossshop shop_glinda
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_glinda]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_glinda:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop



