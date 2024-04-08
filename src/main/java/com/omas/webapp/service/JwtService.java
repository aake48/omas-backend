package com.omas.webapp.service;

import io.jsonwebtoken.Claims; 
import io.jsonwebtoken.Jwts; 
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component; 
import java.util.Date; 
import java.util.HashMap; 
import java.util.Map; 
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Value;

@Component
public class JwtService { 
	
	@Value("${jwt.secret}")
	private String secret; 

	@Value("${jwt.durationOfValidity}")
	private long durationOfValidity = 1000 * 60 * 60 * 1;
	
	public String generateToken(String userName, Long userId) { 
		Map<String, Object> claims = new HashMap<>(); 
		claims.put("userId", userId);
		return createToken(claims, userName); 
	} 

	private String createToken(Map<String, Object> claims, String userName) { 
		return Jwts.builder() 
				.claims(claims) 
				.subject(userName)
				.issuedAt(new Date(System.currentTimeMillis())) 
				.expiration(new Date(System.currentTimeMillis() + durationOfValidity)) 
				. signWith(Keys.hmacShaKeyFor(secret.getBytes())).compact(); 
	} 

	public Long extractUserId(String token) { 
		return extractClaim(token, claims -> claims.get("userId", Long.class)); 
	} 

	public String extractUsername(String token) { 
		return extractClaim(token, Claims::getSubject); 
	} 

	public Date extractExpiration(String token) { 
		return extractClaim(token, Claims::getExpiration); 
	} 

	public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) { 
		final Claims claims = extractAllClaims(token); 
		return claimsResolver.apply(claims); 
	} 

	private Claims extractAllClaims(String token) { 
		return Jwts.parser().verifyWith(Keys.hmacShaKeyFor(secret.getBytes())).build().parseSignedClaims(token).getPayload();		
	} 

	private Boolean isTokenExpired(String token) {
		return extractExpiration(token).before(new Date());
	} 

	public Boolean validateToken(String token, UserInfoDetails userInfoDetails) {
		final String usernameToken = extractUsername(token); 
		final Long userIdToken = extractUserId(token); 
		
		return (usernameToken.equals(userInfoDetails.getUsername()) && !isTokenExpired(token) && userIdToken.equals(userInfoDetails.getId()) );
	} 


} 
