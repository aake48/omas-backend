package com.omas.webapp;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

public final class Json {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static JsonNode parse(String json) throws JsonProcessingException {
        return MAPPER.readTree(json);
    }

    public static JsonNode toJson(Object object) {
        return MAPPER.valueToTree(object);
    }

    public static <T> T fromString(String string, Class<T> clazz) throws JsonProcessingException {
        return MAPPER.readValue(string, clazz);
    }

    public static <T> T fromString(String string, TypeReference<T> reference) throws JsonProcessingException {
        return MAPPER.readValue(string, reference);
    }

    public static <T> T fromJson(JsonNode node, Class<T> clazz) throws JsonProcessingException {
        return MAPPER.treeToValue(node, clazz);
    }

    public static String stringify(Object value, boolean pretty) throws JsonProcessingException {

        ObjectWriter writer = MAPPER.writer();

        if (pretty) {
            writer = writer.with(SerializationFeature.INDENT_OUTPUT);
        }

        return writer.writeValueAsString(value);
    }

    public static ObjectNode objectNode() {
        return MAPPER.createObjectNode();
    }

    public static ArrayNode arrayNode() {
        return MAPPER.createArrayNode();
    }

}
