package br.gov.rs.parobe.helpdesk.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.CharacterEncodingFilter;

import br.gov.rs.parobe.helpdesk.dao.UsuarioDAO;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private UsuarioDAO usuarioDao;
	
	
	/**
	 * Configuracoes de autorizacao
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
	    filter.setEncoding("UTF-8");
	    filter.setForceEncoding(true);
	    http.addFilterBefore(filter,CsrfFilter.class);

		http.authorizeRequests()
			.antMatchers("/resources/**").permitAll()
			.antMatchers("/").permitAll()
			.antMatchers("/home").hasRole("USER")
			.antMatchers("/home/garregaChart").hasRole("USER")
			.antMatchers("/operador").hasRole("ADMIN")
			.antMatchers("/operador/*").hasRole("ADMIN")
			.antMatchers("/operador/operadorEditarPerfil").hasRole("ADMIN")
			
			.antMatchers("/usuario").hasRole("ADMIN")
			.antMatchers("/usuario/*").hasRole("ADMIN")
			.antMatchers("/usuario/usuarioEditarPerfil").hasRole("ADMIN")

			.antMatchers("/solicitante").hasRole("SUP")
			.antMatchers("/solicitante/*").hasRole("SUP")
			.antMatchers("/solicitante/solicitanteVincularSetor").hasRole("SUP")
			.antMatchers("/solicitante/solicitanteVincularSetor/*").hasRole("SUP")
		
			.antMatchers("/setor").hasRole("SUP")
			.antMatchers("/setor/*").hasRole("SUP")
			
			.antMatchers("/categoria").hasRole("SUP")
			.antMatchers("/categoria/*").hasRole("SUP")
			.antMatchers("/categoria/categoriaVincularSubCategoria/").hasRole("SUP")
			.antMatchers("/categoria/categoriaVincularSubCategoria/*").hasRole("SUP")

			.antMatchers("/subCategoria").hasRole("SUP")
			.antMatchers("/subCategoria/*").hasRole("SUP")

			.antMatchers("/tipoCategoria").hasRole("SUP")
			.antMatchers("/tipoCategoria/*").hasRole("SUP")
			
			.antMatchers("/chamadoOperador").hasRole("SUP")
			.antMatchers("/chamadoOperador/*").hasRole("SUP")
			.antMatchers("/chamadoOperador/chamadoIniciarAtendimento/").hasRole("SUP")
			.antMatchers("/chamadoOperador/chamadoIniciarAtendimento/*").hasRole("SUP")
			.antMatchers("/chamadoOperador/mensagensChamadoOperador/").hasRole("SUP")
			.antMatchers("/chamadoOperador/mensagensChamadoOperador/*").hasRole("SUP")

			.antMatchers("/relatorioChamadoEstatistico").hasRole("SUP")
			.antMatchers("/relatorioChamadoEstatistico/*").hasRole("SUP")
			
			.antMatchers("/usuarioAlteraDados").hasRole("USER")
			.antMatchers("/atualizarSenhaUsuario").hasRole("USER")
			.antMatchers("/chamadoSolicitante").hasRole("USER")
			.antMatchers("/chamadoSolicitante/*").hasRole("USER")
			.antMatchers("/chamadoSolicitante/mensagensChamadoSolicitante/").hasRole("USER")
			.antMatchers("/chamadoSolicitante/mensagensChamadoSolicitante/*").hasRole("USER")
			.anyRequest().authenticated()
			.and()
				.formLogin().loginPage("/login").defaultSuccessUrl("/home").permitAll()
			.and()
				.logout()
	            .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).permitAll() 
	            .logoutSuccessUrl("/login")
	            .and().exceptionHandling().accessDeniedPage("/WEB-INF/views/erros/403.jsp");
	}
	
	/**
     * Configuracoes de autenticacao
     */
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(usuarioDao)
				.passwordEncoder(passwordEncoder());
	}
	
    /**
     * Configuracoes para recursos estaticos
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**","/error**");
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
