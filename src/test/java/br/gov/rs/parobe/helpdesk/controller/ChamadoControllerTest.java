package br.gov.rs.parobe.helpdesk.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import br.gov.rs.parobe.helpdesk.configuration.AppWebConfiguration;
import br.gov.rs.parobe.helpdesk.configuration.JPAConfiguration;
import br.gov.rs.parobe.helpdesk.configuration.SecurityConfiguration;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {JPAConfiguration.class, AppWebConfiguration.class, SecurityConfiguration.class})
@ActiveProfiles("test")
public class ChamadoControllerTest {

	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup(){
	    mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Test
	public void deveRetornarLogin() throws Exception {
	    mockMvc.perform(MockMvcRequestBuilders.get("/"))
	    	.andExpect(MockMvcResultMatchers.forwardedUrl("/WEB-INF/views/login.jsp"));
	}
	
	@Test
	public void somenteAdminDeveAcessarOperador() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/operador/operador")
				.with(SecurityMockMvcRequestPostProcessors
				.user("suporte.ti@parobe.rs.gob.br")
				.password("123456")
				.roles("USER")))
				.andExpect(MockMvcResultMatchers.status().is(200));
	}
}
