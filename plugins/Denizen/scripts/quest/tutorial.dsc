tut_data:
    type: data
    id: tutorial
    category: Adventure
    name: <dark_aqua>Tutorial <gold>Quest
    spacing: 
    icon: <element[<&chr[E363]>].font[minecraft:default]>
    tip_frame:
        frame: <element[<&chr[e368]>].font[minecraft:dialogue_icons].color[white]>
    locations:
        crist_coords: 34.5,84,105.5
        crist_ltext: Talk to Crist
        bank_teller: Talk to bank teller
        bank_coords: 6.5,84,46.5
        world: isla
        silver_key: 35,83,105
        coin_item: 8,84,46
    dialogues:
        crates_1: <element[<dark_aqua>Crates<reset> can be open using <gold>crates].color[white].font[lore_line1]>
        crates_2: <element[<gold>keys<reset>. And this will give you a].color[white].font[lore_line2]>
        crates_3: <element[random rewards.].color[white].font[lore_line3]>
        cristd_1: <element[You can obtain <gold>crates keys<reset> from].color[white].font[lore_line1]>
        cristd_2: <element[daily rewards or server store].color[white].font[lore_line2]>
        cristd_3: <element[and to support the server aswell.].color[white].font[lore_line3]>
        bank_1: Welcome to the bank where you
        bank_2: can deposit your coins, in order
        bank_3: to use in the market.

silver_key:
    type: item
    debug: false
    material: stick
    display name: "<white>Silver key"
    mechanisms:
        custom_model_data: 101


ui_tutorial_guide:
    type: task
    debug: false
    script:
    - if <player.location.world.name> == isla:
        - if !<player.has_flag[started_tutorial]>:
            - define negative_space <proc[negative_spacing].context[365].font[utility:spacing]>
            - define icon <script[tut_data].parsed_key[icon]>
            - define npc_crist_loc <location[<script[tut_data].data_key[locations.crist_coords]>]>
            - define ltext <script[tut_data].data_key[locations.crist_ltext]>
#██Remove "flag <player> started_tutorial:! and flag <player> enter_started_tutorial:!"" TO repeat this tutorial quest
            - flag <player> started_tutorial
            - flag <player> ui_tutorial
            - run nbar_task def:<[npc_crist_loc]>|<gold><[ltext]>
            - bossbar create ui_tutorial players:<player> "title:<[negative_space]><[icon]> " color:white
remove_ui_tutorial:
    type: world
    debug: false
    events:
        on player starts sneaking flagged:ui_tutorial:
        - if <player.has_flag[ui_tutorial]>:
            - bossbar remove ui_tutorial
            - flag <player> ui_tutorial:!
            - playsound <player> custom sound:custom.sound.close_dialogue volume:1
Quest_tutorial:
    type: world
    debug: false
    events:
        on player enters start_tutorial:
        - if !<player.has_flag[start_tutorial]>:
            - if !<player.has_flag[started_tutorial]>:
                - run ui_tutorial_guide
                - playsound <player> custom sound:custom.sound.open_dialogue volume:1

#██##############################################██CRATES TUTORIAL██##############################################██
crates_scene_1:
    type: task
    debug: false
    script:
        - if <player.has_flag[enter_started_tutorial]>:
#██Remove crates_scene flag /flag <player> crates_scene:!
            - flag <player> crates_scene
            - define frame <proc[negative_spacing].context[65].font[utility:spacing]><script[tut_data].parsed_key[tip_frame.frame]>
            - define crates_dial_1 <proc[negative_spacing].context[123].font[utility:spacing]><script[tut_data].parsed_key[dialogues.crates_1]>
            - define crates_dial_2 <proc[negative_spacing].context[120].font[utility:spacing]><script[tut_data].parsed_key[dialogues.crates_2]>
            - define crates_dial_3 <proc[negative_spacing].context[105].font[utility:spacing]><script[tut_data].parsed_key[dialogues.crates_3]>
            - while <player.has_flag[crates_scene]>:
                - title "subtitle:<[frame]><[crates_dial_1]><[crates_dial_2]><[crates_dial_3]> " fade_in:0s stay:12t fade_out:0s
                - wait 10t
crates_scene_2:
    type: task
    debug: false
    script:
        - if <player.has_flag[enter_started_tutorial]>:
            - flag <player> crates_scene
            - flag <player> <player.uuid>.get_silver_key
            - define frame <proc[negative_spacing].context[0].font[utility:spacing]><script[tut_data].parsed_key[tip_frame.frame]>
            - define cristd_1 <proc[negative_spacing].context[123].font[utility:spacing]><script[tut_data].parsed_key[dialogues.cristd_1]>
            - define cristd_2 <proc[negative_spacing].context[120].font[utility:spacing]><script[tut_data].parsed_key[dialogues.cristd_2]>
            - define cristd_3 <proc[negative_spacing].context[111].font[utility:spacing]><script[tut_data].parsed_key[dialogues.cristd_3]>
            - while <player.has_flag[crates_scene]>:
                - title "subtitle:<[frame]><[cristd_1]><[cristd_2]><[cristd_3]> " fade_in:0s stay:12t fade_out:0s
                - wait 10t
#██This is to remove or to disable the to play the crates cinematic again
remove_crates_scene:
    type: task
    debug: false
    script:
        - flag <player> crates_scene:!
#██Crates cinematic tutorial
entry_crates_first:
    type: world
    debug: false
    events:
        on player enters crates_loc:
        - if !<player.has_flag[play_crates]>:
            - execute as_op "dcutscene play crates"
            - playsound <player> custom sound:custom.sound.open_dialogue volume:1
            - flag <player> enter_started_tutorial
            - flag <player> play_crates

silver_key_task:
    type: task
    debug: false
    script:
        - if <player.has_flag[<player.uuid>.get_silver_key]>:
            - define silver_key <item[silver_key]>
            - define skey_coords <script[tut_data].data_key[locations.silver_key]>,isla
            - define skey_loc <Location[<[skey_coords]>].simple>
            - displayitem <[silver_key]> <[skey_loc]> duration:8s save:sil_key
            - define skey <entry[sil_key].dropped>
            - flag <entry[sil_key].dropped> silkey:<[skey_coords]>
reset_tutorial:
    type: task
    debug: false
    script:
        - flag <player> started_tutorial:!
        - flag <player> play_crates:!
        - flag <player> obtain_skey:!
#██##############################################██BANK TUTORIAL██##############################################██
#this is for bank toturial
exits_crates:
    type: world
    debug: false
    events:
        on player exits crates_loc:
        - if !<player.has_flag[to_bank]>:
            - run ui_tutorial_guide_to_bank
#██Remove this flag to add the bank arrow guide "flag <player> to_bank:!"
            - flag <player> to_bank
            - flag <player> play_bank

#██Show coin item i bank scene
show_coin_task:
    type: task
    debug: false
    script:
        - if !<player.has_flag[<player.uuid>.coin_item]>:
            - define coin <item[coins_item]>
            - define coin_coords <script[tut_data].data_key[locations.coin_item]>,isla
            - define coin_loc <Location[<[coin_coords]>].simple>
            - displayitem <[coin]> <[coin_loc]> duration:5s save:coin_item
            - define save_coin <entry[coin_item].dropped>
            - flag <entry[coin_item].dropped> coin_item:<[coin_loc]>
#██Guide to the bank
ui_tutorial_guide_to_bank:
    type: task
    debug: false
    script:
    - if <player.location.world.name> == isla:
        - if !<player.has_flag[bank_tutorial]>:
            - define npc_bank_coords <location[<script[tut_data].data_key[locations.bank_coords]>]>
            - define bank_ltext <script[tut_data].data_key[locations.bank_teller]>
            # - flag <player> bank_tutorial
            - run nbar_task def:<[npc_bank_coords]>|<gold><[bank_ltext]>
#██UI Bank ScreenChat
bank_task_2:
    type: task
    debug: false
    script:
    - if <player.location.world.name> == isla:
        - if !<player.has_flag[bank_tutorial]>:
            - define frame <script[tut_data].parsed_key[tip_frame.frame]>
            - define bank_d1 <script[tut_data].parsed_key[dialogues.bank_1].color[white].font[lore_line1]>
            - define bank_d2 <script[tut_data].parsed_key[dialogues.bank_2].color[white].font[lore_line2]>
            - define bank_d3 <script[tut_data].parsed_key[dialogues.bank_3].color[white].font[lore_line3]>
            - define frame_space <proc[negative_spacing].context[45].font[utility:spacing]><[frame]>
            - define bank_1 <proc[negative_spacing].context[123].font[utility:spacing]><element[<[bank_d1]>]>
            - define bank_2 <proc[negative_spacing].context[117].font[utility:spacing]><element[<[bank_d2]>]>
            - define bank_3 <proc[negative_spacing].context[123].font[utility:spacing]><element[<[bank_d3]>]>
            - flag <player> bank_tutorial_2
            - while <player.has_flag[bank_tutorial_2]>:
                - title "subtitle:<[frame_space]><[bank_1]> <[bank_2]> <[bank_3]> " fade_in:0s stay:12t fade_out:0s
                - wait 10t
#██Play Bank cinematic
entry_bank:
    type: world
    debug: false
    events:
        on player enters bank_loc:
        - if <player.has_flag[play_bank]>:
            - execute as_op "dcutscene play bank"
#██Remove this flag to play the bank_scene again "flag <player> to_bank:!"
            - flag <player> play_bank:!
#██Remove bank ScreenChat
remove_bank_dialogue:
    type: task
    debug: false
    script:
        - flag <player> bank_tutorial_2:!
remove_bank_scene:
    type: task
    debug: false
    script:
        - flag <player> to_bank:!
        - flag <player> play_bank:!