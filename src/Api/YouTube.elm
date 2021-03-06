module Api.YouTube exposing (..)

{-| Auto-generated using http://noredink.github.io/json-to-elm/
-}

-- import Json.Encode

import Json.Decode exposing (Decoder, string, list, int, map, fail, andThen, field)
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional)
import Http
import String
import Maybe
import Secrets


searchUrl : String -> String
searchUrl searchTerm =
    let
        path =
            "https://www.googleapis.com/youtube/v3/search"

        query =
            [ ( "part", "snippet" )
            , ( "q", searchTerm )
            , ( "key", Secrets.youtube )
            ]

        queryString =
            query
                |> List.map (\( k, v ) -> k ++ "=" ++ (Http.encodeUri v))
                |> String.join "&"
    in
        path ++ "?" ++ queryString


getFirstEmbedUrl : SearchResult -> Maybe String
getFirstEmbedUrl searchResult =
    let
        getVideoId item =
            case item.id of
                Video id ->
                    Just id

                _ ->
                    Nothing
    in
        searchResult.items
            |> List.filterMap getVideoId
            |> List.head
            |> Maybe.map (String.append "https://www.youtube.com/embed/")


type alias SearchResult =
    { kind : String
    , etag : String
    , nextPageToken : String
    , regionCode : String
    , pageInfo : SearchPageInfo
    , items : List SearchResultItem
    }


type alias SearchPageInfo =
    { totalResults : Int
    , resultsPerPage : Int
    }


type alias SearchResultItem =
    { kind : String
    , etag : String
    , id : SearchResultItemId
    , snippet : SearchResultItemSnippet
    }


type SearchResultItemId
    = Channel String
    | Video String
    | Playlist String


type alias SearchResultItemSnippetThumbnail =
    { url : String
    }


type alias SearchResultItemSnippetThumbnails =
    { default : SearchResultItemSnippetThumbnail
    , medium : SearchResultItemSnippetThumbnail
    , high : SearchResultItemSnippetThumbnail
    }


type alias SearchResultItemSnippet =
    { publishedAt : String
    , channelId : String
    , title : String
    , description : String
    , thumbnails : SearchResultItemSnippetThumbnails
    , channelTitle : String
    , liveBroadcastContent : String
    }


decodeSearchResult : Decoder SearchResult
decodeSearchResult =
    decode SearchResult
        |> required "kind" (string)
        |> required "etag" (string)
        |> optional "nextPageToken" (string) ""
        |> required "regionCode" (string)
        |> required "pageInfo" (decodeSearchPageInfo)
        |> required "items" (list decodeSearchResultItem)


decodeSearchPageInfo : Decoder SearchPageInfo
decodeSearchPageInfo =
    decode SearchPageInfo
        |> required "totalResults" (int)
        |> required "resultsPerPage" (int)


decodeSearchResultItem : Decoder SearchResultItem
decodeSearchResultItem =
    decode SearchResultItem
        |> required "kind" (string)
        |> required "etag" (string)
        |> required "id" (decodeSearchResultItemId)
        |> required "snippet" (decodeSearchResultItemSnippet)


decodeSearchResultItemId : Decoder SearchResultItemId
decodeSearchResultItemId =
    (field "kind" string) |> andThen idKind


idKind : String -> Decoder SearchResultItemId
idKind kind =
    case kind of
        "youtube#channel" ->
            map Channel (field "channelId" string)

        "youtube#video" ->
            map Video (field "videoId" string)

        "youtube#playlist" ->
            map Playlist (field "playlistId" string)

        _ ->
            fail "Unknown kind of YouTube object"


decodeSearchResultItemSnippetThumbnail : Decoder SearchResultItemSnippetThumbnail
decodeSearchResultItemSnippetThumbnail =
    decode SearchResultItemSnippetThumbnail
        |> required "url" (string)


decodeSearchResultItemSnippetThumbnails : Decoder SearchResultItemSnippetThumbnails
decodeSearchResultItemSnippetThumbnails =
    decode SearchResultItemSnippetThumbnails
        |> required "default" (decodeSearchResultItemSnippetThumbnail)
        |> required "medium" (decodeSearchResultItemSnippetThumbnail)
        |> required "high" (decodeSearchResultItemSnippetThumbnail)


decodeSearchResultItemSnippet : Decoder SearchResultItemSnippet
decodeSearchResultItemSnippet =
    decode SearchResultItemSnippet
        |> required "publishedAt" (string)
        |> required "channelId" (string)
        |> required "title" (string)
        |> required "description" (string)
        |> required "thumbnails" (decodeSearchResultItemSnippetThumbnails)
        |> required "channelTitle" (string)
        |> required "liveBroadcastContent" (string)



-- encodeSearch : Search -> Json.Encode.Value
-- encodeSearch record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("etag",  Json.Encode.string <| record.etag)
--         , ("nextPageToken",  Json.Encode.string <| record.nextPageToken)
--         , ("regionCode",  Json.Encode.string <| record.regionCode)
--         , ("pageInfo",  encodeSearchPageInfo <| record.pageInfo)
--         , ("items",  Json.Encode.list <| List.map encodeSearchResultItem <| record.items)
--         ]
-- encodeSearchPageInfo : SearchPageInfo -> Json.Encode.Value
-- encodeSearchPageInfo record =
--     Json.Encode.object
--         [ ("totalResults",  Json.Encode.int <| record.totalResults)
--         , ("resultsPerPage",  Json.Encode.int <| record.resultsPerPage)
--         ]
-- encodeSearchResultItem : SearchResultItem -> Json.Encode.Value
-- encodeSearchResultItem record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("etag",  Json.Encode.string <| record.etag)
--         , ("id",  encodeSearchResultItemId <| record.id)
--         , ("snippet",  encodeSearchResultItemSnippet <| record.snippet)
--         ]
-- encodeSearchResultItemId : SearchResultItemId -> Json.Encode.Value
-- encodeSearchResultItemId record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("channelId",  Json.Encode.string <| record.channelId)
--         ]
-- encodeSearchResultItemSnippetThumbnailsDefault : SearchResultItemSnippetThumbnailsDefault -> Json.Encode.Value
-- encodeSearchResultItemSnippetThumbnailsDefault record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]
-- encodeSearchResultItemSnippetThumbnailsMedium : SearchResultItemSnippetThumbnailsMedium -> Json.Encode.Value
-- encodeSearchResultItemSnippetThumbnailsMedium record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]
-- encodeSearchResultItemSnippetThumbnailsHigh : SearchResultItemSnippetThumbnailsHigh -> Json.Encode.Value
-- encodeSearchResultItemSnippetThumbnailsHigh record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]
-- encodeSearchResultItemSnippetThumbnails : SearchResultItemSnippetThumbnails -> Json.Encode.Value
-- encodeSearchResultItemSnippetThumbnails record =
--     Json.Encode.object
--         [ ("default",  encodeSearchResultItemSnippetThumbnailsDefault <| record.default)
--         , ("medium",  encodeSearchResultItemSnippetThumbnailsMedium <| record.medium)
--         , ("high",  encodeSearchResultItemSnippetThumbnailsHigh <| record.high)
--         ]
-- encodeSearchResultItemSnippet : SearchResultItemSnippet -> Json.Encode.Value
-- encodeSearchResultItemSnippet record =
--     Json.Encode.object
--         [ ("publishedAt",  Json.Encode.string <| record.publishedAt)
--         , ("channelId",  Json.Encode.string <| record.channelId)
--         , ("title",  Json.Encode.string <| record.title)
--         , ("description",  Json.Encode.string <| record.description)
--         , ("thumbnails",  encodeSearchResultItemSnippetThumbnails <| record.thumbnails)
--         , ("channelTitle",  Json.Encode.string <| record.channelTitle)
--         , ("liveBroadcastContent",  Json.Encode.string <| record.liveBroadcastContent)
--         ]
