/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sistemaTransporteFluvialTest;

import junit.framework.TestCase;
import mundo.Passenger;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author eliecer
 */
public class PassengerTest extends TestCase
{
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    private Passenger passenger;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    /**
     * Se construye un fluvial passenger con una ruta asignada en estado libre,
     * con un tiempo de recorrido de ruta de 2 horas sin uso de panico
     */
    public void escenario1() 
    {
        passenger=new Passenger(3, true, 23.43, 24.40, 33, 2, 11, false,0);
    }
    /**
     * Se construye un Fluvial Passenger con una ruta asignada en estado ocupado,
     * sin uso de panico
     */
    public void escenario2() 
    {
        passenger=new Passenger(6, false, 50.25, 51.03, 10, 0, 11, false,20);
    }
    /**
     * 
     */
    public void escenario3() 
    {
        passenger=new Passenger(15, false, 50.25, 51.03, 10, 0, 11, true,30);
    }
}