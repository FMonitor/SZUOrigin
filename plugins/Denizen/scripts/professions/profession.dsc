profession_command:
    type: command
    name: Profession
    debug: false
    usage: /Profession
    description: <dark_gray>Choose your Profession using <aqua>profession <dark_gray>to your guild
    aliases:
        - job
        - jobs
        - profession
        - guild
    permission: profession.use
    permission message: Sorry, <player.name>, you can't use my command because you don't have the permission '<[permission]>'!
    tab complete:
    - determine g|job|jobs|guild|profession
    script:
    - if !<player.has_flag[has_profession]>:
        - inventory open d:open_profession_container
    - else if <player.has_flag[miner_profession]>:
        - execute as_op minerguild silent
    - else if <player.has_flag[warrior_profession]>:
        - execute as_op warriorguild silent
    - else if <player.has_flag[farmer_profession]>:
        - execute as_op farmerguild silent
    - else if <player.has_flag[timber_profession]>:
        - execute as_op timberguild silent

open_profession_container:
    type: inventory
    debug: false
    inventory: CHEST
    title: <proc[negative_spacing].context[30].font[utility:spacing]><white><&chr[e372]>
    size: 54
    gui: true
    slots:
    - [miner_lore] [miner_lore] [miner_lore] [miner_lore] [] [farmer_lore] [farmer_lore] [farmer_lore] [farmer_lore]
    - [miner_lore] [miner_lore] [miner_lore] [miner_lore] [] [farmer_lore] [farmer_lore] [farmer_lore] [farmer_lore]
    - [miner_lore] [miner_lore] [miner_select] [miner_select] [] [farmer_lore] [farmer_lore] [farmer_select] [farmer_select]
    - [timber_lore] [timber_lore] [timber_lore] [timber_lore] [] [warrior_lore] [warrior_lore] [warrior_lore] [warrior_lore]
    - [timber_lore] [timber_lore] [timber_lore] [timber_lore] [] [warrior_lore] [warrior_lore] [warrior_lore] [warrior_lore]
    - [timber_lore] [timber_lore] [timber_select] [timber_select] [] [warrior_lore] [warrior_lore] [warrior_select] [warrior_select]

QuestActiveItem:
    type: item
    material: paper
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 100080
QuestInactiveItem:
    type: item
    material: paper
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 100081
QuestCompleted:
    type: item
    material: paper
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 100082
QuestCompletedUnclaim:
    type: item
    material: paper
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 100083
QuestLocked:
    type: item
    material: paper
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 100084

