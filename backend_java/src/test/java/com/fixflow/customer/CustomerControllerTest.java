package com.fixflow.customer;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import java.time.LocalDateTime;
import java.util.List;

import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(CustomerController.class)
class CustomerControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private CustomerService customerService;

    @Test
    void getAllCustomersReturnsCustomerJsonWithoutPasswordHash() throws Exception {
        given(customerService.getAllCustomers()).willReturn(List.of(
                new CustomerResponse(
                        1,
                        "Rahul Kumar",
                        "rahul@gmail.com",
                        "9876543210",
                        "MG Road",
                        "Bangalore",
                        LocalDateTime.of(2026, 10, 1, 12, 0))));

        mockMvc.perform(get("/api/customers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].customerId").value(1))
                .andExpect(jsonPath("$[0].name").value("Rahul Kumar"))
                .andExpect(jsonPath("$[0].city").value("Bangalore"))
                .andExpect(jsonPath("$[0].passwordHash").doesNotExist());
    }
}