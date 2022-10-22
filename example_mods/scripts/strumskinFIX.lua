--I broke noteskins somehow so i will re-add it in lua - curbstopthetap (crushernotdrip)
--18
--7
function onCreatePost()
    for i = 0, 3 do
        if getProperty('dad.curCharacter') == 'amorbuis' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_amorbuis_assets')
        end
        if getProperty('dad.curCharacter') == 'baking ron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE__assets')
        end
        if getProperty('dad.curCharacter') == 'bambi' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bambi_assets')
        end
        if getProperty('dad.curCharacter') == 'bob baking 2' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob baking 2_assets')
        end
        if getProperty('dad.curCharacter') == 'bob baking' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob baking_assets')
        end
        if getProperty('dad.curCharacter') == 'bob drip' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob drip_assets')
        end
        if getProperty('dad.curCharacter') == 'bob joe' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob joe_assets')
        end
        if getProperty('dad.curCharacter') == 'bob' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob_assets')
        end
        if getProperty('dad.curCharacter') == 'bob-angry' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob-angry_assets')
        end
        if getProperty('dad.curCharacter') == 'bobhell' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bobhell_assets')
        end
        if getProperty('dad.curCharacter') == 'bobOG' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bobOG_assets')
        end
        if getProperty('dad.curCharacter') == 'cooking ron 2' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_cooking ron 2_assets')
        end
        if getProperty('dad.curCharacter') == 'dripron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_dripron_assets')
        end
        if getProperty('dad.curCharacter') == 'little man' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_little man_assets')
        end
        if getProperty('dad.curCharacter') == 'ron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ron_assets')
        end
        if getProperty('dad.curCharacter') == 'ronjoe' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronjoe_assets')
        end
        if getProperty('dad.curCharacter') == 'ronny mc ronny' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronny mc ronny_assets')
        end
        if getProperty('dad.curCharacter') == 'ronOG' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronOG_assets')
        end
    end
    for i = 4, 7 do
    for iuN = 0, getProperty('unspawnNotes.length')-1 do
        if getProperty('boyfriend.curCharacter') == 'amorbuis' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_amorbuis_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'baking ron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE__assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bambi' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bambi_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bob baking 2' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob baking 2_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_bob baking 2')
        end
        if getProperty('boyfriend.curCharacter') == 'bob baking' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob baking_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_bob baking')
        end
        if getProperty('boyfriend.curCharacter') == 'bob drip' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob drip_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_bob drip')
        end
        if getProperty('boyfriend.curCharacter') == 'bob joe' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob joe_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bob' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bob-angry' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bob-angry_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bobhell' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bobhell_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'bobOG' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_bobOG_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'cooking ron 2' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_cooking ron 2_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'dripron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_dripron_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'little man' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_little man_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_little man')
        end
        if getProperty('boyfriend.curCharacter') == 'ron' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ron_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_ron')
        end
        if getProperty('boyfriend.curCharacter') == 'ronjoe' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronjoe_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_ronjoe')
        end
        if getProperty('boyfriend.curCharacter') == 'ronny mc ronny' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronny mc ronny_assets')
        end
        if getProperty('boyfriend.curCharacter') == 'ronOG' then
            setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_ronOG_assets')
            setPropertyFromGroup('unspawnNotes', iuN, 'noteSplashTexture', 'noteSplashes_ronOG')
        end
    end
    end
end