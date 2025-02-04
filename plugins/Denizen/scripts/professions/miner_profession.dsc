miner_lore:
    type: item
    material: feather
    debug: false
    display name: <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e25c]><proc[negative_spacing].context[100].font[utility:spacing]><aqua><bold>ᴍɪɴᴇʀ<proc[negative_spacing].context[10].font[utility:spacing]>
    mechanisms:
        custom_model_data: 10041
    lore:
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[165].font[utility:spacing]><gray>This guild mostly focus <proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[165].font[utility:spacing]><gray>in mining. Their guild is<proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[165].font[utility:spacing]><gray>the only one who can mine<proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[165].font[utility:spacing]><gray>a special ores from village.<proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e360]><proc[negative_spacing].context[10].font[utility:spacing]>
miner_select:
    type: item
    material: feather
    debug: false
    display name: <white>
    mechanisms:
        custom_model_data: 10041
    lore:
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e25c]><proc[negative_spacing].context[108].font[utility:spacing]><green><bold>ᴄᴏɴꜰɪʀᴍ<proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e359]><proc[negative_spacing].context[165].font[utility:spacing]>          <gray>CLICK TO SELECT<proc[negative_spacing].context[10].font[utility:spacing]>
    - <proc[negative_spacing].context[4].font[utility:spacing]><white><&chr[e360]><proc[negative_spacing].context[10].font[utility:spacing]>


confirmed_miner:
    type: world
    debug: false
    events:
        on player clicks miner_select in open_profession_container:
        - if !<player.has_flag[miner_profession]>:
            - flag <player> miner_profession
            - flag <player> has_profession
            - inventory close
            - title "subtitle:<gold>You choose to become <yellow>Miner<gold>!" fade_in:1s stay:4s fade_out:3s targets:<player>

miner_profession_container:
    type: inventory
    debug: false
    inventory: CHEST
    title: <proc[negative_spacing].context[8].font[utility:spacing]><white><&chr[e224]>
    size: 45
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []