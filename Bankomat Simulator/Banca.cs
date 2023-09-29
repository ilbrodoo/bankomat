using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;
using static BankomatSimulator.ContoCorrente;

namespace BankomatSimulator
{
 
    class Banca
    {
        public enum Funzionalita
        {
            Versamento,
            Prelievo,
            ReportSaldo,
            Sblocco,
            Uscita
        }


        public enum EsitoLogin
        {
            AccessoConsentito,
            UtentePasswordErrati,
            PasswordErrata,
            AccountBloccato
        }


        private string _nome;
        private List<Utente> _utenti;
        private SortedList<int,Funzionalita> _funzionalita;


        private Utenti _utenteCorrente;

        public string Nome { get => _nome; set => _nome = value; }

        public Utenti UtenteCorrente { get => _utenteCorrente; set => _utenteCorrente = value; }
        internal SortedList<int, Funzionalita> ElencoFunzionalita { get => _funzionalita; set => _funzionalita = value; }

        /// <summary>
        /// Verifica che sia presente un utente con NomeUtente uguale a quello indicato
        /// e, nel caso, verifica la password.
        /// </summary>
        /// <param name="credenziali">Dati inseriti dall'utente </param>
        /// <returns></returns>
        public EsitoLogin Login(Utenti credenziali, out Utente utente, BancomatEntities ctx)
        {
            
            Utente utenteDaValidare = null;
            //ricerco utente sul 
            utente = null;

            foreach (Utenti elem in ctx.Utentis)
            {
                if(elem.NomeUtente == credenziali.NomeUtente)
                {
                    utenteDaValidare = elem;
                    break;
                }
            }
            if (utenteDaValidare == null)
            {
                return EsitoLogin.UtentePasswordErrati;
            }
              
            
            if (credenziali.Password != utenteDaValidare.Password)
            {
                utente = utenteDaValidare;
                utente.Tentativi++;
                if (utenteDaValidare.Bloccato)
                {
                    return EsitoLogin.AccountBloccato;
                }
                return EsitoLogin.PasswordErrata;
            }
            else
            {
                utente = utenteDaValidare;
                if (utenteDaValidare.Bloccato)
                {
                    return EsitoLogin.AccountBloccato;
                }
                utente.Tentativi = 0;
                return EsitoLogin.AccessoConsentito;   
            }
        }


    }
}
