librarian_npc_dialogue:
    type: data
    debug: false
    name_frame:
        dialogue_frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    librarian:
        librarian_icon: <element[<&chr[e25d]>].font[minecraft:dialogue_icons].color[white]>
        librarian_name: Librarian
        #Element must contain a maximum or not more than 23 characters
        librarian1: Welcome to our hallowed
        librarian2: library dear adventurer!
        librarian3: Please choose your guild.
    guild:
        diaquest1: You're here to check what
        diaquest2: are the available quests
        diaquest3: from your guild.

librarian_npc_exit:
    type: world
    debug: false
    events:
        after player starts sneaking flagged:talking_to_librarian:
        - run talking_to_librarian
        on player left clicks air flagged:talking_to_librarian:
        - run talking_to_librarian
        on player steps on block flagged:talking_to_librarian:
        - run talking_to_librarian

talking_to_librarian:
    type: task
    debug: false
    script:
        - if <player.has_flag[talking_to_librarian]>:
            - adjust <player> fov_multiplier:0
            - flag <player> talking_to_librarian:!
            - fakeequip head:carved_pumpkin for:<player> duration:10t
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
            - stop

npc_librarian_assignment:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true
        - trigger name:proximity state:true radius:1
    interact scripts:
    - npc_librarian_interact
npc_librarian_interact:
    type: interact
    debug: false
    steps:
        default*:
            click trigger:
                1:
                    script:
                    #██FRAME
                    - define d_frame_spaces <proc[negative_spacing].context[15].font[utility:spacing]>
                    - define d_frame <script[librarian_npc_dialogue].parsed_key[name_frame.dialogue_frame]>
                    - define d_librarian_frame <[d_frame_spaces]><[d_frame]>
                    #██ICON
                    - define librarian_space_icon <proc[negative_spacing].context[126].font[utility:spacing]>
                    - define librarian_icon <script[librarian_npc_dialogue].parsed_key[librarian.librarian_icon]>
                    - define icon <[librarian_space_icon]><[librarian_icon]>
                    #██NAME
                    - define librarian_name_space <proc[negative_spacing].context[1].font[utility:spacing]>
                    - define librarian_name_get <script[librarian_npc_dialogue].parsed_key[librarian.librarian_name]>
                    - define librarian_name_color <element[<[librarian_name_get]>].color[GOLD].font[lore_line1]>
                    - define librarian_name <[librarian_name_space]><[librarian_name_color]>
                    #██Line 1
                    - define librarian_d1_space <proc[negative_spacing].context[35].font[utility:spacing]>
                    - define librarian_d1_get <script[librarian_npc_dialogue].parsed_key[librarian.librarian1]>
                    - define librarian_d1_color <element[<[librarian_d1_get]>].color[white].font[lore_line2]>
                    - define librarian_d1 <[librarian_d1_space]><[librarian_d1_color]>
                    #██Line 2
                    - define librarian_d2_space <proc[negative_spacing].context[85].font[utility:spacing]>
                    - define librarian_d2_get <script[librarian_npc_dialogue].parsed_key[librarian.librarian2]>
                    - define librarian_d2_color <element[<[librarian_d2_get]>].color[white].font[lore_line3]>
                    - define librarian_d2 <[librarian_d2_space]><[librarian_d2_color]>
                    #██Line 3
                    - define librarian_d3_space <proc[negative_spacing].context[89].font[utility:spacing]>
                    - define librarian_d3_get <script[librarian_npc_dialogue].parsed_key[librarian.librarian3]>
                    - define librarian_d3_color <element[<[librarian_d3_get]>].color[white].font[lore_line4]>
                    - define librarian_d3 <[librarian_d3_space]><[librarian_d3_color]>
                    - if !<player.has_flag[has_profession]>:
                        - if !<player.has_flag[talking_to_librarian]>:
                            - adjust <player> fov_multiplier:1
                            - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                            - fakeequip head:carved_pumpkin for:<player>
                            - flag <player> talking_to_librarian
                            #██ Remove this flag to disable librarian dialogues"
                            - if <player.has_flag[talking_to_librarian]>:
                                - title "subtitle:<[d_librarian_frame]><[icon]> <[librarian_name]><[librarian_d1]><[librarian_d2]><[librarian_d3]> " fade_in:0s stay:1s fade_out:1s
                            - wait 40t
                            - run talking_to_librarian
                            - inventory open d:open_profession_container

                    - else:
                        #██Line 1
                        - define quest_d1_space <proc[negative_spacing].context[34].font[utility:spacing]>
                        - define quest_d1_get <script[librarian_npc_dialogue].parsed_key[guild.diaquest1]>
                        - define quest_d1_color <element[<[quest_d1_get]>].color[white].font[lore_line2]>
                        - define quest_d1 <[quest_d1_space]><[quest_d1_color]>
                        #██Line 2
                        - define quest_d2_space <proc[negative_spacing].context[95].font[utility:spacing]>
                        - define quest_d2_get <script[librarian_npc_dialogue].parsed_key[guild.diaquest2]>
                        - define quest_d2_color <element[<[quest_d2_get]>].color[white].font[lore_line3]>
                        - define quest_d2 <[quest_d2_space]><[quest_d2_color]>
                        #██Line 3
                        - define quest_d3_space <proc[negative_spacing].context[88].font[utility:spacing]>
                        - define quest_d3_get <script[librarian_npc_dialogue].parsed_key[guild.diaquest3]>
                        - define quest_d3_color <element[<[quest_d3_get]>].color[white].font[lore_line4]>
                        - define quest_d3 <[quest_d3_space]><[quest_d3_color]>
                        - if !<player.has_flag[talking_to_librarian]>:
                            - adjust <player> fov_multiplier:1
                            - playsound <player> custom sound:custom.sound.open_dialogue volume:1
                            - fakeequip head:carved_pumpkin for:<player>
                            - title "subtitle:<[d_librarian_frame]><[icon]> <[librarian_name]><[quest_d1]><[quest_d2]><[quest_d3]> " fade_in:0s stay:1s fade_out:1s
                            - wait 40t
                            - flag <player> talking_to_librarian
                            - run talking_to_librarian
                            - execute as_op profession silent
            proximity trigger:
                exit:
                    script:
                    - if <player.has_flag[talking_to_librarian]>:
                        - adjust <player> fov_multiplier:0
                        - flag <player> talking_to_librarian:!
                        - fakeequip head:carved_pumpkin for:<player> duration:10t
                        - playsound <player> custom sound:custom.sound.close_dialogue volume:1
                        - stop
