package com.omas.webapp;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

public final class Json {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static JsonNode parse(String json) throws JsonProcessingException {
        return MAPPER.readTree(json);
    }

    public static JsonNode fromJson(Object object) {
        return MAPPER.valueToTree(object);
    }

    public static String stringify(JsonNode node, boolean pretty) throws JsonProcessingException {

        if (pretty) {
            return MAPPER.writer().writeValueAsString(node);
        } else {
            return MAPPER.writerWithDefaultPrettyPrinter().writeValueAsString(node);
        }

    }

    public static ObjectNode objectNode() {
        return MAPPER.createObjectNode();
    }

    public static ArrayNode arrayNode() {
        return MAPPER.createArrayNode();
    }

}
