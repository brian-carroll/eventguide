port module Styles exposing (main)

-- External packages

import Css exposing (..)
import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Maybe.Extra


-- Local modules

import Styles.Selectors exposing (..)
import Styles.Card
import Styles.BgOverlay
import Styles.Modal


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", Css.File.compile [ css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure


css : Stylesheet
css =
    mergeStyleSheets
        [ Styles.Card.css
        , Styles.BgOverlay.css
        , Styles.Modal.css
        ]


mergeStyleSheets : List Stylesheet -> Stylesheet
mergeStyleSheets sheets =
    { charset = mergeCharSets <| List.map .charset sheets
    , imports = List.concat <| List.map .imports sheets
    , namespaces = List.concat <| List.map .namespaces sheets
    , snippets = List.concat <| List.map .snippets sheets
    }


{-| Why yes, I do have too much time on my hands. Thank you for asking.
-}
mergeCharSets : List (Maybe String) -> Maybe String
mergeCharSets charsets =
    case Maybe.Extra.values charsets of
        [] ->
            Nothing

        h :: t ->
            if List.all ((==) h) t then
                Just h
            else
                Debug.crash
                    ("Can't merge stylesheets with different `@charsets` : "
                        ++ toString charsets
                    )
